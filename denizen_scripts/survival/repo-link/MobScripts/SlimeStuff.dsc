slime_damage_handler:
  type: world
  debug: false
  events:
    on player damaged by slime:
#Check for Mythicmob
      - if <context.damager.is_mythicmob> && <context.damager.MythicMob.level.is[MORE].to[5]>:
#Generate random equipment slot
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
#Check for empty slot or invalid item
      - if !<player.equipment_map.contains[<[equipment]>]> || !<player.equipment_map.get[<[equipment]>].ends_with[_helmet]>:
        - actionbar "<&e>Acid splashes on you, burning your <[body_part]>."
        - determine <context.damager.mythicmob.level.mul[5]>
#Define variables
      - define item <player.equipment_map.get[<[equipment]>]>
      - define Durrbillty <[item].durability.add[<context.damager.mythicmob.level.sub.[6].mul[<context.damager.size.div[2].round_up>]>]>
#Item break check
      - if <[item].repairable>:
        - if <[Durrbillty]> >= <[item].max_durability>:
          - playeffect effect:ITEM_CRACK at:<player.location.above[0.5].forward[0.4]> special_data:<[item]> offset:0.2 quantity:15
          - playsound <context.location> sound:ENTITY_ITEM_BREAK
          - take slot:<[slot]>
#Item Durability Damage
        - else:
          - inventory adjust slot:<[slot]> durability:<[Durrbillty]>
#Damage player
      - determine <context.damager.mythicmob.level.mul[3]>

slime_puddle_creator:
  type: world
  debug: false
  script:
  - if <context.entity.is_mythicmob.entity[SLIME1]>
    - define Puddlesize <context.entity.size.div[2]>
    - define Puddle_Location <player.location.find.surface_blocks.within[Puddlesize]>
    - flag server blocks_to_remove.<[Puddle_Location].simple>:<[Puddle_Location].material>
    - modifyblock <[Puddle_Location]> slime_block
    - wait 5s
    - if <server.has_flag[blocks_to_remove.<[Puddle_Location].simple>]>:
      - modifyblock <[Puddle_Location]> <server.flag[blocks_to_remove.<[Puddle_Location].simple>].as_material>

player_slime_block_break_handler:
  type: world
  debug: false
  script:
  on player breaks:slime_block
  - if <server.has_flag[blocks_to_remove.<[context.location].simple>]>:
    - modifyblock <[Puddle_Location]> <server.flag[blocks_to_remove.<[Puddle_Location].simple>].as_material>
    - playeffect effect:BLOCK_CRACK at:<context.location> special_data:SLIME_BLOCK quantity:20
    - playsound <context.location> sound:BLOCK_SLIME_BLOCK_BREAK
