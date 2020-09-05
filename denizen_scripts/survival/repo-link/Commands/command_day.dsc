Day_command:
    type: command
    name: Day
    usage: /day
    alias:
    - daymanfighterofthenightman
    description: Sets to daytime
    permission: adriftus.staff
    script:
    - time global 1000t mainland
    - Announce "<&e>Time set to <&dq>Day<&dq> by <yaml[global.player.<player.uuid>].read[display_name]>""
