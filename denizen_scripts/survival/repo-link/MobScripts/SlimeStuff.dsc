slime_mob_handler:
  type: world
  debug: false
  events:
    on player damaged by slime:
      - if <context.damager.is_mythicmob> && <context.damager.MythicMob.level.is[MORE].to[5]>:
        - choose <util.random.int[1].to[4]>:
          - case 1:
            - define equipment helmet
            - define slot 40
            - define body_part face
          - case 2:
            - define equipment chestplate
            - define slot 39
            - define body_part chest
          - case 3:
            - define equipment leggings
            - define slot 38
            - define body_part legs
          - case 4:
            - define equipment boots
            - define slot 37
            - define body_part feet
      - if !<player.equipment_map.contains[<[equipment]>]> || <player.equipment_map.get[<[equipment]>].ends_with[_helmet]>:
        - actionbar "<&e>Acid splashes on you, burning your <[body_part]>."
        - determine <context.damager.mythicmob.level.mul[5]>

      - define item <player.equipment_map.get[<[equipment]>]>
      - if <[item].repairable>:
        - if <[item].durability.add[<context.damager.mythicmob.level.sub[5]>]> >= <[item].max_durability>:
          - playeffect effect:ITEM_CRACK at:<player.location.above[0.5].forward[0.4]> special_data:<[item]> offset:0.2 quantity:15
          - take slot:<[slot]>
        - else:
          - inventory adjust slot:<[slot]> durability:<[item].durability.add[<context.damager.mythicmob.level.sub.[6].mul[<context.damager.size.div[2].round_up>]>]>
        - determine <context.damager.mythicmob.level.mul[3]>
