tutorial_data:
  type: data
  particle_trail:
    particle: totem
    quantity: 5
    offset: 0.5
  continue_button: "<&a>Click me to Continue"
  complete_button: "<&a>Complete Tutorial"
  start:
    hologram:
      - "<&6>Welcome To Adriftus Survival"
      - "<&e>Click one of the options below to begin."
    start_button: "<&a>Start Tutorial"
    skip_button: "<&4>Skip Tutorial"
  1:
    hologram:
      - "<&6><&l>Adriftus Survival"
      - "<&a>This tutorial will teach you the server rules."
      - "<&a>It will also walk you through the basic commands."
    particle_guide: true
  2:
    hologram:
      - "<&6><&l>Rule <&ns>1"
      - "<&e>No harrassing other players."
      - "<&c>Stop Means Stop."
    particle_guide: true
  3:
    hologram:
      - "<&6><&l>Rule <&ns>2"
      - "<&e>Avoid profanity in public channels."
      - "<&c>Keep your language kid appropriate."
    particle_guide: true
  4:
    hologram:
      - "<&6><&l>Vote Crates"
      - "<&e>Voting for our server will earn you rewards."
      - "<&e>use <&b>/vote <&e>to find out how."
    particle_guide: true
  5:
    hologram:
      - "<&6><&l>Soul Forge"
      - "<&e>Here you can forge your items with souls."
      - "<&c>Souls can be acquired in the <&4>Savage Lands."
    particle_guide: true
  6:
    hologram:
      - "<&6><&l>The Market"
      - "<&e>You can buy all sorts of upgrades and items here!"
      - "<&e>Be sure to check out the stocks and cosmetic vendors."
      - "<&e>You can also get daily rewards!"
    title: "<&6>Use <&b>/warps"
    subtitle: "Go to the server warp: Marketplace"
  7:
    hologram:
      - "<&6><&l>Cosmetics"
      - "<&e>Here you can purchase titles and bow trails!"
      - "<&c>Use <&6>/titles<&e> and <&6>/bowtrails<&e> to use them."
    particle_guide: true
  8:
    hologram:
      - "<&6><&l>Claims"
      - "<&e>Here you can purchase upgrades for your claim."
      - "<&c>Upgrades only apply within your claim."
    particle_guide: true
  9:
    hologram:
      - "<&6><&l>Mystery Boxes"
      - "<&e>Here you can purchase mysterious packages."
      - "<&e>Who knows what they might contain."
    particle_guide: true
  10:
    hologram:
      - "<&6><&l>Stonks!"
      - "<&e>Our Stonks Broker buys and sells items."
      - "<&e>Prices fluctuate, so check back often!"
    particle_guide: true
  11:
    hologram:
      - "<&6><&l>Survivalist"
      - "<&e>Want a little something a little more useful?"
      - "<&e>The survivalist sells backpacks, tents, and more!"
    particle_guide: true
  12:
    hologram:
      - "<&6><&l>Daily Rewards"
      - "<&e>Wait a minute, is that you from the future?"
      - "<&e>Maybe you have something to give yourself."
      - "<&c>Each day you can recieve a daily reward."
    particle_guide: true
  13:
    hologram:
      - "<&6><&l>Warp Command"
      - "<&b>Warps can be made by any player within their claim."
      - "<&e>You can visit server warps, or other player's warps."
      - "<&a>Command Menu<&co> <&b>/warps"
      - "<&a>--------------------------"
      - "<&e>Use <&b>/warps <&e>and go to Grim to continue."
    particle_guide: true
    message: "<&6>/warp <&e>to the server warp<&co> Grim"
  14:
    hologram:
      - "<&6><&l>Grim"
      - "<&e>Grim can help you return to your death location."
      - "<&c>Be aware, nothing is free."
    particle_guide: true
  15:
    hologram:
      - "<&6><&l>Claims"
      - "<&e>You can claim land!"
      - "<&e>You can also give access to different groups of players."
      - "<&e>If a group doesn't exist, it will be created."
      - "<&e>You can manage everything related to chunks in the GUI."
      - "<&a>Command<&co> <&b>/claims"
    particle_guide: true
  16:
    hologram:
      - "<&6><&l>The World (1/2)"
      - "<&e>The world is split into 2 sections<&co>"
      - "<&e>The <&c>Savage Lands <&e>are the inner 20,000 blocks."
      - "<&e>The <&2>Outer Realms <&e>are everywhere outside of that."
    particle_guide: true
  17:
    hologram:
      - "<&6><&l>The World Part (2/2)"
      - "<&e>The <&c>Savage Lands &ehave <&c>PvP Enabled."
      - "<&e>Beware of encounters there as monsters will spawn."
      - "<&e>The <&2>Outer Realms <&e>are a safe haven."
      - "<&e>No monsters will spawn, and PvP is disabled."
    particle_guide: true
  18:
    hologram:
      - "<&6><&l>Chat"
      - "<&e>We have cross-server chat available"
      - "<&e>Use <&6>/chat<&e> to change your channel"
      - "<&e>You can also click on the channel name in chat!"
      - "<&a>Please keep our rules in mind."
    particle_guide: true
  19:
    hologram:
      - "<&6><&l>End Game"
      - "<&e>The closer to the center of the world you get,"
      - "<&e>Monsters will be harder to defeat, and drop better loot."
      - "<&e>The only <&d>Ender Portal <&e>resides at the bottom of a dungeon in the center."
      - "<&e>Should you manage to endure the challenge, powerful rewards await."
    particle_guide: true
    run_task: tutorial_spawn_finale
  20:
    hologram:
      - "<&a><&l>Start Your Journey"
      - "<&e>Jump through the hole to be teleported to the game world."
      - "<&e>If you need any additional help, consult <&b>/help<&e>."
      - "<&e>You can return to spawn at any point with <&b>/spawn<&e>."
      - "<&e>Make sure you <&b>/sethome <&c>if you like where you land."
      - "<&c>There is no other way to return to the same location."
    particle_guide: true


##########################
## TUTORIAL RUN SCRIPTS ##
##########################

tutorial_spawn_finale:
  type: task
  script:
    - fakespawn ender_dragon <location[tutorial_dragon]> duration:10m


###############
## INTERNALS ##
###############

tutorial_command:
  type: command
  name: tutorial
  description: Start the Tutorial!
  usage: /tutorial
  script:
    - inject tutorial_start

tutorial_start:
  type: task
  script:
    - teleport <player> tutorial_start
    - flag player tutorial:0
    - foreach <script[tutorial_data].parsed_key[start.hologram]>:
      - fakespawn armor_stand[custom_name_visible=true;visible=false;custom_name=<[value]>] <location[tutorial_start_hologram].sub[0,<[loop_index].*[0.25]>,0]> duration:10m
    - fakespawn armor_stand[custom_name_visible=true;visible=false;marker=true;custom_name=<&a><&b><script[tutorial_data].parsed_key[start.start_button]>] <location[tutorial_start_hologram].right[1.5].sub[0,<script[tutorial_data].parsed_key[start.hologram].size.*[0.25]>,0]> duration:10m
    - fakespawn armor_stand[visible=false;custom_name=ContinueTutorial] <location[tutorial_start_hologram].right[1.5].sub[0,<script[tutorial_data].parsed_key[start.hologram].size.+[4].*[0.25]>,0]> duration:10m
    - fakespawn armor_stand[custom_name_visible=true;visible=false;marker=true;custom_name=<&b><&a><script[tutorial_data].parsed_key[start.skip_button]>] <location[tutorial_start_hologram].left[1.5].sub[0,<script[tutorial_data].parsed_key[start.hologram].size.*[0.25]>,0]> duration:10m
    - fakespawn armor_stand[visible=false;custom_name=SkipTutorial] <location[tutorial_start_hologram].left[1.5].sub[0,<script[tutorial_data].parsed_key[start.hologram].size.+[4].*[0.25]>,0]> duration:10m

tutorial_next:
  type: task
  script:
    - define stage <player.flag[tutorial]>
    - if <location[tutorial_<[stage]>]||null> != null:
      - run tutorial_timeout def:<[stage]>
      - if <script[tutorial_data].list_keys[<[stage]>].contains[run_task]>:
        - run <script[tutorial_data].parsed_key[<[stage]>.run_task]>
      - if <script[tutorial_data].list_keys[<[stage]>].contains[title]>:
        - if <script[tutorial_data].list_keys[<[stage]>].contains[subtitle]>:
          - title title:<script[tutorial_data].parsed_key[<[stage]>.title]> subtitle:<script[tutorial_data].parsed_key[<[stage]>.subtitle]>
        - else:
          - title title:<script[tutorial_data].parsed_key[<[stage]>.title]>
      - if <script[tutorial_data].list_keys[<[stage]>].contains[message]>:
        - narrate <script[tutorial_data].parsed_key[<[stage]>.message]>
      - if <script[tutorial_data].list_keys[<[stage]>].contains[particle_guide]> && <script[tutorial_data].parsed_key[<[stage]>.particle_guide]>:
        - look <player> tutorial_<[stage]>
        - while <player.location.world.name> == spawn && <player.location.distance[<location[tutorial_<[stage]>]>]> > 7:
          - define points <player.location.points_between[<location[tutorial_<[stage]>]>].get[3].to[last]>
          - foreach <[points]>:
            - if !<player.is_online>:
              - flag player tutorial:!
              - stop
            - while <[value].material.name> != air:
              - define value <[value].above[2]>
            - playeffect <script[tutorial_data].parsed_key[particle_trail.particle]> at:<[value]> quantity:<script[tutorial_data].parsed_key[particle_trail.quantity]> offset:<script[tutorial_data].parsed_key[particle_trail.offset]> targets:<player>
            - wait 1t
          - if <player.location.distance[<location[tutorial_<[stage]>]>]> > <[last_distance].+[5]||100>:
            - narrate "<&e>You have gone too far from your next tutorial location."
            - narrate "<&e>You may restart it at any time by using <&b>/tutorial"
            - inject tutorial_skipped
            - stop
          - else if <player.location.distance[<location[tutorial_<[stage]>]>]> < <[last_distance]||100>:
            - define last_distance <player.location.distance[<location[tutorial_<[stage]>]>]>
          - wait 5t
      - foreach <script[tutorial_data].parsed_key[<[stage]>.hologram]>:
        - fakespawn armor_stand[custom_name_visible=true;marker=true;visible=false;custom_name=<[value]>] <location[tutorial_<[stage]>].above[3].sub[0,<[loop_index].*[0.25]>,0]> duration:10m
      - if <script[tutorial_data].parsed_key[<[stage].+[1]>]||null> == null:
        - fakespawn armor_stand[custom_name_visible=true;marker=true;visible=false;custom_name=<script[tutorial_data].parsed_key[complete_button]>] <location[tutorial_<[stage]>].above[1]> duration:10m
      - else:
        - fakespawn armor_stand[custom_name_visible=true;marker=true;visible=false;custom_name=<script[tutorial_data].parsed_key[continue_button]>] <location[tutorial_<[stage]>].above[1]> duration:10m
      - fakespawn armor_stand[visible=false;custom_name=ContinueTutorial] <location[tutorial_<[stage]>]> duration:10m
      - stop
    - flag player tutorial:!
    - flag player tutorial_status:completed
    - narrate "<&a>You have completed the tutorial!"
    - narrate "<&a>Please jump through the hole in front of you to begin your journey!"

tutorial_timeout:
  type: task
  definitions: stage
  script:
    - while <player.flag[tutorial]||null> == <[stage]>:
      - if <queue.time_ran> > <duration[10m]>:
        - inject tutorial_skipped
        - narrate "<&e>Your tutorial has timed out."
        - narrate "<&e>You may use <&b>/tutorial<&e> at any time to restart it."
      - wait 10s

tutorial_skipped:
  type: task
  script:
    - foreach <player.fake_entities>:
      - fakespawn <[value]> cancel
    - flag player tutorial:!
    - flag player tutorial_status:skipped


tutorial_events:
  type: world
  events:
    on player clicks fake entity flagged:tutorial:
      - if <context.entity.name> == ContinueTutorial:
        - foreach <player.fake_entities>:
          - fakespawn <[value]> cancel
        - flag player tutorial:++
        - run tutorial_next
      - else if <context.entity.name> == SkipTutorial:
        - foreach <player.fake_entities>:
          - fakespawn <[value]> cancel
        - inject tutorial_skipped
        - narrate "<&e>You have opted to skip the tutorial."
        - narrate "<&e>Please view <&b>/help <&e>for any questions."
        - narrate "<&e>You can restart the tutorial at any time by using <&b>/tutorial<&e>."
    on player exits spawn_cuboid flagged:tutorial:
      - inject tutorial_skipped
      - narrate "<&e>You have exited spawn, and stopped the tutorial."
      - narrate "<&e>You can restart the tutorial at any time by using <&b>/tutorial<&e>."
