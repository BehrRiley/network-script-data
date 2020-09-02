feed_command:
    type: command
    name: feed
    usage: /feed (player)
    description: feeds a player
    permission: adriftus.staff
    script:
    - if <context.args.size> > 1:
        - inject command_syntax
    - if <context.args.is_empty>:
        - feed 20 <player>
        - narrate "You have been fed."
    - else:
        - define user <context.args.first>
        - inject player_verification
        - feed 20 <[user]>
        - narrate "<player> has been fed"
        - narrate "<user> has fed you" targets:<player>
