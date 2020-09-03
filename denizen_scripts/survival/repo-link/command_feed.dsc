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
        - feed amount:20 <player>
        - narrate "You have been fed."
    - else:
        - define user <context.args.first>
        - inject player_verification
        - feed amount:20 <[user]>
<<<<<<< HEAD
        - narrate "<user> has been fed"
        - narrate "<player.name> has fed you" targets:<user>
=======
        - narrate "<[user].name> has been fed"
        - narrate "<player.name> has fed you" targets:<[user]>
>>>>>>> upstream/master
