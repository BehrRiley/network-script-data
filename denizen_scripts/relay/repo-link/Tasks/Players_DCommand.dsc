Players_DCommand:
    type: task
    PermissionRoles:
    # % ██ [ Staff Roles  ] ██
        - Lead Developer
        - External Developer
        - Developer

    # % ██ [ Public Roles ] ██
        - Lead Developer
        - Developer
    definitions: Message|Channel|Author|Group
    script:
    # % ██ [ Clean Definitions & Inject Dependencies ] ██
    - inject Role_Verification
    - inject Command_Arg_Registry
    
    # % ██ [ No Arguments ] ██
    - if <[Args].is_empty>:
        - define final_map <map>
        - foreach hub1|survival|behrcraft as:s:
            - ~bungeetag server:<[s]> <server.online_players.to_map[<server.online_players.parse[display_name.strip_color]>]> save:map
            - define map <entry[map].result>
            - foreach <[map]>:
                - if <[key]> == <[value]>:
                    - define map <[map].with[<[key]>].as[-<&sp><[value]>]>
                - else:
                    - define map <[map].with[<[key]>].as[-<&sp><[value]><&sp>(<[key]>)]>
            - if <[map].is_empty>:
                - define final_map "<[final_map].with[**<[s]>**].as[No players online.]>"
            - else:
                - define final_map <[final_map].with[**<[s]>**].as[<[map].values.insert[```md].at[1].include[```]>]>
        - foreach final_map:
            - define text:->:<[key]>
            - define text:|:<[value]>
        - define color yellow
        - define title "Online Players"
        - define definitions <list_single[<map.with[text].as[<[text].separated_by[<n>]>].with[color].as[<[color]>].with[title].as[<[title]>]>]>
        - bungeerun relay webhook_generic def:<list[generic_webhooks].include_single[<[definitions]>]>
    # % ██ [ One Arguments ] ██
    - else if <[Args].size> == 1:
        - if <list[s|show].contains[<[Args].first.before[:]>]>:
            - if <[Args].first.after[:].contains[<&pipe>]>:
                - define server_list <[Args].first.after[:].split[|]>
                - foreach <[server_list]>:
                    - if <bungee.list_servers.exclude[relay].contains[<[value]>].not>:
                        - define server_list:<-:<[value]>
                        - define invalid_list:->:<[value]>
                - define final_map <map>
                - foreach <[server_list].include[hub1|behrcraft|survival].deduplicate> as:s:
                    - ~bungeetag server:<[s]> <server.online_players.to_map[<server.online_players.parse[display_name.strip_color]>]> save:map
                    - define map <entry[map].result>
                    - foreach <[map]>:
                        - if <[key]> == <[value]>:
                            - define map <[map].with[<[key]>].as[-<&sp><[value]>]>
                        - else:
                            - define map <[map].with[<[key]>].as[-<&sp><[value]><&sp>(<[key]>)]>
                    - if <[map].is_empty>:
                        - define final_map "<[final_map].with[**<[s]>**].as[No players online.]>"
                    - else:
                        - define final_map <[final_map].with[**<[s]>**].as[<[map].values.insert[```md].at[1].include[```]>]>
                - foreach final_map:
                    - define text:->:<[key]>
                    - define text:|:<[value]>
                - if <[invalid_list]||null> != null:
                    - define "text:->:**Note**: `Invalid server(s): <[invalid_list].formatted>`"
            - else:
                - if <bungee.list_servers.exclude[relay].contains[<[Args].first>].not>:
                    - stop
                - ~bungeetag server:<[Args].first> <server.online_players.to_map[<server.online_players.parse[display_name.strip_color]>]> save:map
                - define map <entry[map].result>
                - foreach <[map]>:
                    - if <[key]> == <[value]>:
                        - define map <[map].with[<[key]>].as[-<&sp><[value]>]>
                    - else:
                        - define map <[map].with[<[key]>].as[-<&sp><[value]><&sp>(<[key]>)]>
                - if <[map].is_empty>:
                    - define text "<list_single[**<[Args].first.to_titlecase>**].include[No players online.]>"
                - else:
                - define text <[map].values.insert[**<[Args].first.to_titlecase>**].at[1].insert[```md].at[2].include[```]>
        - define color yellow
        - define title "Online Players"
        - define definitions <list_single[<map.with[text].as[<[text].separated_by[<n>]>].with[color].as[<[color]>].with[title].as[<[title]>].with[channel].as[<[channel]>]>]>
        - bungeerun relay webhook_generic def:<list[generic_webhooks].include_single[<[definitions]>]>
    - else:
        - stop
