channel_cache:
    type: task
    debug: false
    speed: 0.2
    script:
        - foreach <yaml[discord_configuration].read[groups]> key:group_name as:group_id:
            - define channels <discordgroup[adriftusbot,<[group_id]>].channels>

            - foreach <[channels]> as:channel:
                - define channel_id <[channel].id>

                - yaml id:discord_channels set <[group_name]>.<[channel_id]>.name:<[channel].name.escaped>
                - yaml id:discord_channels set <[group_name]>.<[channel_id]>.position:<[channel].position>
                - yaml id:discord_channels set <[group_name]>.<[channel_id]>.channel_type:<[channel].channel_type>
                - yaml id:discord_channels set <[group_name]>.<[channel_id]>.topic:<[channel].topic.escaped>

            - if !<yaml[discord_channels].list_keys[<[group_name]>].exclude[<[channels].parse[id]>].is_empty>:
                - foreach <yaml[discord_channels].list_keys[<[group_name]>].exclude[<[channels].parse[id]>]> as:deprecated_channel_id:
                    - define deprecated_channel <discordchannel[adriftusbot,<[channel_id]>]>
                    - yaml id:discord_channels set archived.<util.time_now.epoch_millis>.<[group_name]>.<[deprecated_channel_id]>:<yaml[discord_channels].read[<[group_name]>.<[deprecated_channel_id]>]>
                    - yaml id:discord_channels set <[group_name]>.<[deprecated_channel_id]>:!

        - yaml id:discord_channels savefile:<yaml[network_configuration].read[configurations.discord_channels]>
