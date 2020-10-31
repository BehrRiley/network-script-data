daily_vote_reciever:
    type: world
    debug: false
    events:
      on votifier vote:
        - define listed_sites <element[to_be_filled_in_when_listed_on_sites]>
        - define voter <server.match_offline_player[<context.username>]||invalid>
        - if <[voter]> != invalid
          - flag <[voter]> daily_votes_reward counter:++
          - flag <[voter]> DailyVotesTotal counter:++
          - wait 1t
          - if <[voter].flag[daily_votes_reward].add[1]> == <[listed_sites]>
            - give <[voter]> daily_vote_crate_key
            - announce "<&a><[voter].display_name> <&c>has just recieved a voter crate key! Do <&3>/<&b>vote<&c> to recieve yours now!
            - flag <[voter]> daily_votes_reward:!


