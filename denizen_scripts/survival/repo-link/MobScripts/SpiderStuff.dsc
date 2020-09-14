Paranoia_poison_canceller:
  type: world
  debug: false
  events:
    on player damaged by cave_spider:
      - if <context.damager.is_mythicmob>:
#Using determine cancelled then hurt to prevent poison on the player from hallucination spiders.
        - if <context.damage.entity.mythicmob.stance> == HALLUCINATED
          - determine passively cancelled
          - hurt <context.damager.mythicmob.level.sub[6]> <player>
