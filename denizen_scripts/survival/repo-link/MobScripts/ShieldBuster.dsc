#Used to make Mythicmobs break shields faster. Shoutout to Pjochillin for making this for me.

on player damaged:
- if <player.item_in_offhand.material.name> == shield:
    - if <context.damager.is_mythicmob>:
        - if <player.item_in_offhand.durability.add[<context.damager.mythicmob.level>]> >= <player.item_in_offhand.max_durability>:
            - playeffect effect:ITEM_CRACK at:<player.location.above[0.5].forward[0.4]> special_data:<player.item_in_offhand.material.name> offset:0.2 quantity:15
            - inventory set slot:<player.item_in_offhand> o:air
            - playsound <player.location> sound:ENTITY_ITEM_BREAK
        - else:
            - inventory adjust slot:<player.item_in_offhand> durability:<player.item_in_offhand.durability.add[<context.damager.mythicmob.level>]>
