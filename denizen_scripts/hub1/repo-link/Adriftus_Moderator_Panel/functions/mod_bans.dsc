# -- Handle server & network bans.
mod_ban_player:
  type: task
  debug: false
  definitions: moderator|uuid|level|infraction|length|global
  script:
    # -- Check if player is online, set YAML ID to edit accordingly.
    - if <[uuid].as_player.is_online>:
      - define id <tern[<[global].exists>].pass[global.].fail[]>player.<[uuid]>
      - yaml id:<[id]> set banned.level:<[level]>
      - yaml id:<[id]> set banned.infraction:<[infraction]>
      - yaml id:<[id]> set banned.length:<[length]>
      - yaml id:<[id]> set banned.date:<util.time_now>
      - yaml id:<[id]> set banned.moderator:<[moderator]>
      - kick <[uuid].as_player> reason:<proc[mod_ban_message].context[<[moderator]>|<[level]>|<[infraction]>|<[length]>|<util.time_now>]>
    - else:
      - define dir data/<tern[<[global].exists>].pass[globalData/].fail[]>players/<[uuid]>.yml
      - define id amp.banned.<[uuid]>
      - ~yaml id:<[id]> load:<[dir]>
      - yaml id:<[id]> set banned.level:<[level]>
      - yaml id:<[id]> set banned.infraction:<[infraction]>
      - yaml id:<[id]> set banned.length:<[length]>
      - yaml id:<[id]> set banned.date:<util.time_now>
      - yaml id:<[id]> set banned.moderator:<[moderator]>
      - ~yaml id:<[id]> savefile:<[dir]>
      - yaml id:<[id]> unload

# -- Handle on login ban checking.
mod_ban_check:
  type: world
  debug: false
  events:
    after player joins:
      # -- Check if player's global/server YAML data contains an ongoing-ban.
      - wait 2s
      - if <yaml[global.player.<player.uuid>].list_keys[].contains[banned]>:
        - define prefix global.player
      - else if <yaml[player.<player.uuid>].list_keys[].contains[banned]>:
        - define prefix player
      - else:
        - stop
      # If duration since ban date/time is greater than the set duration, remove the banned key from player data.
      - if <util.time_now.duration_since[<yaml[<[prefix]>.<player.uuid>].read[banned.date]>].in_seconds> > <yaml[<[prefix]>.<player.uuid>].read[banned.length].as_duration.in_seconds>:
        - narrate "<&6>You were banned for <&e><yaml[<[prefix]>.<player.uuid>].read[banned.infraction]> <&6>for <&6><yaml[<[prefix]>.<player.uuid>].read[banned.length]>."
        - narrate "<&6>Your temporary ban is up. Please review the rules to prevent future incidents."
        - yaml id:<[prefix]>.<player.uuid> set banned:!
      # Else, kick 'em.
      - else:
        - kick <player> reason:<proc[mod_ban_message].context[<yaml[<[prefix]>.<player.uuid>].read[banned.moderator]>|<yaml[<[prefix]>.<player.uuid>].read[banned.level]>|<yaml[<[prefix]>.<player.uuid>].read[banned.infraction]>|<yaml[<[prefix]>.<player.uuid>].read[banned.length]>|<yaml[<[prefix]>.<player.uuid>].read[banned.date]>]>
