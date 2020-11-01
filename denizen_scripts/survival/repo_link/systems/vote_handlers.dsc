vote_reciever:
  type: world
  debug: false
  events:
    #Vote Recieved:
      on votifier vote:
      - define listed_sites <element[to_be_filled_in_when_listed_on_sites]>
      - define voter <server.match_offline_player[<context.username>]||invalid>
      - if <[voter]> != invalid:
        - inject daily_vote_counter
        - inject weekly_vote_counter
  #Check for offline keys and award/announce
      on player joins:
      - if <player.flag[weekly_crate_pending]>:
        - narrate: "<&e>You have a <item[weekly_vote_key].display> <&e>pending. Do <&3>/<&b>weeklykeys <&e>to claim it.!"
      - if <player.flag[enderchest_daily_key_offline]> > 0:
        - if <player.flag[enderchest_daily_key_offline]> > 1:
        - narrate "<&e>Your inventory was full and <&a><player.flag[enderchest_daily_key_offline]> <item[daily_vote_key].display>s<&e> were deposited into your enderchest!"
      - else:
        - narrate "<&e>Your inventory was full and <&a>a <item[daily_vote_key].display>s<&e> was deposited into your enderchest!"
      - if <player.flag[inventory_daily_key_offline]> > 0:
        - if <player.flag[inventory_daily_key_offline]> > 1:
        - narrate "<&e>You recieved <player.flag[inventory_daily_key]> <item[daily_vote_key].display>s<&e> while offline!"
      - else:
        - narrate "<&e>You recieved <&a>a <item[daily_vote_key].display><&e> while you were offline!"
      - if <player.flag[daily_key_pending]> > 0:
        - if <player.flag[daily_key_pending]> > 1:
          - narrate "<&c>You have <player.flag[daily_key_pending]> <item[daily_vote_key].display>s<&c> waiting for you at <&3>/<&b>recoverkeys."
        - else:
          - narrate "<&c>You have a <item[daily_vote_key].display><&c> waiting for you at <&3>/<&b>recoverkeys."
      - if <player.flag[enderchest_daily_key_offline].add[<player.flag[inventory_daily_key_offline]>]> > 0:
        - if <player.flag[enderchest_daily_key_offline].add[<player.flag[inventory_daily_key_offline]>]> > 1:
          - announce "<&c><player.display_name> has recieved <&a><player.flag[enderchest_daily_key_offline].add[<player.flag[inventory_daily_key]>]> <item[daily_vote_key].display>s<&c> for voting while offline!<&nl><&c>Do <&3>/<&b>vote<&c> to recieve yours now!"
        - else:
          - announce "<&a><player.display_name> <&c>has just recieved a <item[daily_vote_key].display><&c>! Do <&3>/<&b>vote<&c> to recieve yours now!""


vote_handler:
  type: task
  debug: false
  daily_vote_counter:
    - flag <[voter]> daily_votes_reward counter:++
    - flag <[voter]> DailyVotesTotal counter:++
    - wait 1t
    - if <[voter].flag[daily_votes_reward]> >= <[listed_sites].sub[1]>:
      - if <[voter].inventory.is_full>:
        - if <[voter].enderchest.is_full>:
          - flag <[voter]> daily_key_pending counter:++
          - flag <[voter]> daily_votes_reward:!
          - if <[voter].is_online>:
            - narrate <[voter]> "<&4>Your inventory, and enderchest was full, your <item[daily_vote_key].display> is waiting for you at <&3>/<&b>recoverkeys."
        - else:
          - give to:<[voter].enderchest> daily_vote_crate_key
          - flag <[voter]> daily_votes_reward:!
          - flag <[voter]> offline_daily_keys counter:++
          - if <[voter].is_online>:
            - narrate <[voter]> "<&c>Your inventory was full, your key has been deposited into your enderchest inventory."
            - announce "<&a><[voter].display_name> <&c>has just recieved a <item[daily_vote_key].display><&c>! Do <&3>/<&b>vote<&c> to recieve yours now!"
          - else:
            - flag <[voter]> enderchest_daily_key_offline counter:++
            - flag <[voter]> offline_daily_keys counter:++
      - else:
        - give <[voter]> daily_vote_crate_key
        - flag <[voter]> daily_votes_reward:!
        - if <[voter].is_online>:
          - announce "<&a><[voter].display_name> <&c>has just recieved a <item[daily_vote_key].display><&c>! Do <&3>/<&b>vote<&c> to recieve yours now!"
        - else:
          - flag <[voter]> inventory_daily_key_offline counter:++
          - flag <[voter]> offline_daily_keys counter:++


  weekly_vote_counter:
    - flag <[voter> weekly_votes_reward counter:++ duration:7d
    - wait 1t
    - if <[voter].flag[weekly_votes_reward].sub[1].mul[7]> >= <[listed_sites]>:
      - flag <[voter]> weekly_crate_pending counter:++
      - flag <[voter> weekly_votes_reward:!
      - if <voter.is_online>:
        - narrate <[voter]> "You have enough votes to claim a <&b>Weekly Vote Crate Key<&c>! Do <&3>/<&b>weeklykeys <&e>to claim them!"

weeklykeys:
  type: command
  debug: false
  usage: /weeklykeys
  description: rewards players with their weekly vote crate keys and resets the flag if flagged. Has a 1 week cooldown. If not flagged/on cooldown it reports.
  script:
  - if <player.has_flag[weekly_crate_pending]> && !<player.has_flag[weekly_key_cooldown]>:
    - if <player.inventory.is_full>:
      - if <player.enderchest.is_full>:
        - narrate "<&c>Your inventory and enderchest are full. Please make some room and try again later to claim your <item[weekly_vote_crate_key].display>!"
      - else:
        - give to:<player.enderchest> weekly_vote_crate_key
        - flag <player> weekly_crate_pending:!
        - flag <player> weekly_key_cooldown duration:7d
        - narrate <[voter]> "<&c>Your inventory was full, your <item[weekly_vote_crate_key].display> has been deposited into your enderchest inventory."
        - announce "<&a><[voter].display_name> <&c>has just recieved a <item[weekly_vote_key].display><&c> for voting every day this week!"
    - else:
      - give <player> weekly_vote_crate_key
      - flag <player> weekly_crate_pending:!
      - flag <player> weekly_key_cooldown duration:7d
      - narrate <[voter]> "<&c>Your <item[weekly_vote_crate_key].display> has been deposited into your inventory."
      - announce "<&a><[voter].display_name> <&c>has just recieved a <item[weekly_vote_key].display><&c> for voting every day this week!"
  - if <player.has_flag[weekly_key_cooldown]>:
    - narrate "<&c>You cannot claim another <item[weekly_vote_crate_key].display> <&c>for <player.has_flag[weekly_key_cooldown].expiration.formatted>"
  - if !<player.has_flag[weekly_crate_pending]>:
    - narrate "<&c>You are not currently eligible to claim a <item[weekly_vote_crate_key].display> at this time. <&nl><&e>Current Progress:<&a><[voter].flag[weekly_votes_reward]><&fs><[voter].flag[weekly_votes_reward].sub[1].mul[7]>"

daily_vote_key:
  type: item
  material: tripwire_hook
  display name: <&b>Daily Vote Crate Key
  mechanisms:
    hides: enchants
    nbt: keytype/daily
  enchantments:
  - unbreaking:3

weekly_vote_key:
  type: item
  material: tripwire_hook
  display name: <&b>Weekly Vote Crate Key
  mechanisms:
    hides: enchants
    nbt: keytype/weekly
  enchantments:
  - unbreaking:3

vote_crate_key_events:
  type: world
  events:
    on player right clicks block with:daily_vote_key|weekly_vote_key ignorecancelled:true:
    - if !<server.has_flag[<context.location.simple>.daily_crate]> && !<server.has_flag[<context.location.simple>.weekly_crate]>:
      - determine passively cancelled
      - ratelimit 20t
      - narrate "<&c>You cannot use that here. Please go to the crates server warp. "
    - if <server.has_flag[<context.location.simple>.daily_crate]>:
      - if <player.item_in_hand> == <item[daily_vote_key]>:
        - determine passively cancelled
        - inject daily_crate_opener
        - narrate "Opening daily crate"
      - if <player.item_in_hand> == <item[weekly_vote_key]>:
        - narrate "<&c>Please use a <item[daily_vote_key].display>."
        - determine passively cancelled
    - if <server.has_flag[<context.location.simple>.weekly_crate]>:
      - if <player.item_in_hand> == <item[weekly_vote_key].display>:
        - determine passively cancelled
        - inject weekly_crate_opener
        - narrate "Opening weekly crate"
      - if <player.item_in_hand> == <item[daily_vote_key]>:
        - narrate "<&c>Please use a <item[weekly_vote_key].display>."
        - determine passively cancelled
