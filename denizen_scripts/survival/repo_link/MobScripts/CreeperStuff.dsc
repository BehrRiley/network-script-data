Creeper_Prime_Signal:
  type: world
  debug: false
  events:
    on entity explosion primes:
      - If <context.entity.is_mythicmob>:
        - mythicsignal <context.entity.mythicmob> PrimetimeShowtime source:<context.entity>

#creeper_vents:
#Placeholder to come later.

#creeper_splosion:
#Placeholder to come later.
