slime_mob_handler:
  type: world
  debug: false
  events:
    on player damaged by slime:
      - if <context.damager.is_mythicmob> && <context.damager.MythicMob.level.is[MORE].to[5]>:
<<<<<<< HEAD
          - determine passively cancelled
          - choose <util.random.int[1].to[4]>:
              - case 1:
                - if <player.equipment_map.contains[helmet]> <player.equipment_map.get[helmet].material.name.ends_with[_Helmet]>:
                  - define slot 40
                  - define item <player.equipment_map.get[helmet].material.name>
                  - determine <context.damager.mythicmob.level.mul[3]>
                - else:
                  - determine <context.damager.mythicmob.level.mul[5]>
                  - narrate "<&e>Acid splashes on you, burning your face."
              - case 2:
                - if <player.equipment_map.contains[chestplate]> <player.equipment_map.get[chestplate].material.name.ends_with[_chestplate]>:
                  - define slot 39
                  - define item <player.equipment_map.get[helmet].material.name>
                  - determine <context.damager.mythicmob.level.mul[3]>
                - else:
                  - determine <context.damager.mythicmob.level.mul[5]>
                  - narrate "<&e>Acid splashes on you, burning your chest."
              - case 3:
                - if <player.equipment_map.contains[leggings]> <player.equipment_map.get[leggings].material.name.ends_with[_leggings]>:
                  - define slot 38
                  - define item <player.equipment_map.get[helmet].material.name>
                  - determine <context.damager.mythicmob.level.mul[3]>
                - else:
                  - determine <context.damager.mythicmob.level.mul[5]>
                  - narrate "<&e>Acid splashes on you, burning your legs."
              - case 4:
                - if <player.equipment_map.contains[boots]> <player.equipment_map.get[boots].material.name.ends_with[_boots]>:
                  - define slot 37
                  - define item <player.equipment_map.get[helmet].material.name>
                  - determine <context.damager.mythicmob.level.mul[3]>
                - else
                  - determine <context.damager.mythicmob.level.multiply[5]>
                  - narrate "<&e>Acid splashes on you, burning your feet."
          - if <[item].durability.add[<context.damager.mythicmob.level.sub[5]>]> >= <[item].max_durability>:
            - playeffect effect:ITEM_CRACK at:<player.location.above[0.5].forward[0.4]> special_data:<[item]> offset:0.2 quantity:15
            - take slot:<[slot]>
          - else:
            - inventory adjust slot:<[slot]> durability:<[item].durability.add[<<context.damager.mythicmob.level.sub.[6]>.multiply[<context.damager.size.div[2].round_up>]>]>
=======
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
>>>>>>> upstream/master
