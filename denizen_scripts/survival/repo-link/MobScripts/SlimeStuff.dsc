armor_degradation:
  type: world
  debug: false
  events:
    on player damaged by slime:
      - if <context.damager.is_mythicmob> && <context.damager.MythicMob.level.is[MORE].to[6]>:
          - determine passively cancelled
          - choose <util.random.int[1].to[4]>:
              - case 1
                - if <player.equipment_map.get[helmet].material.name> == *_helmet|turtle_helmet
                  - define slot 40
                  - define item <player.equipment_map.get[helmet].material.name>
                  - hurt <context.damager.mythicmob.level.multiply[3]>
                - else
                  - hurt <context.damager.mythicmob.level.multiply[5]>
                  - narrate "<&e>Acid splashes on you, burning your face."
              - case 2
                - if <player.equipment_map.get[chestplate].material.name> == *_chestplate
                  - define slot 39
                  - define item <player.equipment_map.get[helmet].material.name>
                  - hurt <context.damager.mythicmob.level.multiply[3]>
                - else
                  - hurt <context.damager.mythicmob.level.multiply[5]>
                  - narrate "<&e>Acid splashes on you, burning your chest."
              - case 3
                - if <player.equipment_map.get[leggings].material.name> == *_leggings
                  - define slot 38
                  - define item <player.equipment_map.get[helmet].material.name>
                  - hurt <context.damager.mythicmob.level.multiply[3]>
                - else
                  - hurt <context.damager.mythicmob.level.multiply[5]>
                  - narrate "<&e>Acid splashes on you, burning your Legs."
              - case 4
                - if <player.equipment_map.get[boots].material.name> == *_boots
                  - define slot 37
                  - define item <player.equipment_map.get[helmet].material.name>
                  - hurt <context.damager.mythicmob.level.multiply[3]>
                - else
                  - hurt <context.damager.mythicmob.level.multiply[5]>
                  - narrate "<&e>Acid splashes on you, burning your feet."
          - if <[item].durability.add[<context.damager.mythicmob.level.sub[5]>]> >= <[item].max_durability>:
            - playeffect effect:ITEM_CRACK at:<player.location.above[0.5].forward[0.4]> special_data:<[item]> offset:0.2 quantity:15
            - take slot:<[slot]>
          - else:
            - inventory adjust slot:<[slot]> durability:<[item].durability.add[<context.damager.mythicmob.level.sub.[6]>]>
