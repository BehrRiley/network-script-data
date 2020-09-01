shield_degradation:
  type: world
  events:
    on player damaged by entity:
      - if <player.item_in_offhand.material.name> == shield && <player.is_blocking> && <context.damager.is_mythicmob> && <player.item_in_offhand.durability.add[<context.damager.mythicmob.level>]> >= <player.item_in_offhand.max_durability>:
        - playeffect effect:ITEM_CRACK at:<player.location.above[0.5].forward[0.4]> special_data:<player.item_in_offhand.material.name> offset:0.2 quantity:15
        - take slot:41
      - else:
        - inventory adjust slot:41 durability:<player.item_in_offhand.durability.add[<context.damager.mythicmob.level>]>