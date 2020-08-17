Embedded_Discord_Message:
    type: task
    debug: true
    definitions: Template|Channel|Definitions
    script:
        - inject Definition_Registry
        #- inject Embedded_Color_Formatting
        - inject Embedded_Time_Formatting
        - if <script[DDTBCTY].list_keys[WebHooks].contains[<[Channel]>]>:
            - define Token <script[DDTBCTY].data_key[WebHooks.<[Channel]>.Hook]>
            - define Data <yaml[webhook_template_<[Template]>].to_json.parsed>
            - ~webget <[Token]> headers:<list[Content-Type/application/json|User-Agent/denizen]> data:<[Data]> save:test
            - narrate <entry[test].result>

Embedded_Discord_Message_New:
    type: task
    debug: false
    definitions: Channel|Definitions
    script:
    # - ██ [ Inject Dependencies                     ] ██
        - inject Definition_Registry
        - define Data <map>
        - define Embeds <map>

        - foreach <list[username|avatar_url|tts]> as:String:
            - if <[<[String]>]||null> != null:
                - define Data <[Data].with[<[String]>].as[<[<[String]>]>]>

        - foreach <list[title|description|author|footer|fields|Thumbnail|image]> as:String:
            - if <[<[String]>]||null> != null:
                - define Embeds <[Embeds].with[<[String]>].as[<[<[String]>]>]>

        - if <[Color]||null> != null:
            - inject Embedded_Color_Formatting
            - if <[Color]> == 0:
                - define Color 5820671
            - define Embeds <[Embeds].with[color].as[<[Color]>]>

        - if <[Timestamp]||null> != null:
            - if <[TimeStamp]> == Default:
                - inject Embedded_Time_Formatting
            - define Embeds <[Embeds].with[timestamp].as[<[Time]>]>

        - define Data <[Data].with[embeds].as[<list[<[Embeds]>]>].to_json>

        - define Hook <script[DDTBCTY].data_key[WebHooks.<[Channel]>.hook]>
        - define headers <list[User-Agent/really|Content-Type/application/json]>
        - ~webget <[Hook]> data:<[Data]> headers:<[Headers]>

Embedded_Webhook:
    type: task
    debug: true
    definitions: Channel|Data
    script:
        - define Hook <script[DDTBCTY].data_key[WebHooks.<[Channel]>.hook]>
        - define headers <list[User-Agent/Adriftus|Content-Type/application/json]>
        - ~webget <[Hook]> data:<[Data]> headers:<[Headers]>
        - inject Web_Debug.Webget_Response
