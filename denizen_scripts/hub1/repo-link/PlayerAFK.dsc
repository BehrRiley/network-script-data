AFK_Functions:
  type: world
  debug: false
  events:
    on delta time minutely every:5:
    - define FlagNode AFKCheck.LastLocation
    - foreach <server.online_players> as:Player:
      - flag <[Player]> <[FlagNode]>:<[Player].location>
    - wait 5m
    - foreach <server.online_players_flagged[<[FlagNode]>]> as:Player:
      - if <[Player].flag[<[FlagNode]>]> == <[Player].location>:
        - kick <[Player]> "reason: You were AFK for 5 minutes!"
    on player quit flagged:AFKCheck.LastLocation:
    - flag player AFKCheck.LastLocation:!
  
