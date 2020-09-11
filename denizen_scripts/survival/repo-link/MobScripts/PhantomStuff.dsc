Purple_phantom_breath:
  type: task
  debug: false
  script:
#KEY EVENT PURPOSEFULLY MISSING. TO BE CALLED BY A MOB
  - repeat 10:
    - playeffect effect:DRAGON_BREATH at:<context.entity.location.add[0,0,0]> velocity:<context.entity.left.down.to_cuboid[<context.target.right.above>].blocks.parse[sub[<context.entity.location>].div[2]]> quantity:4
    - playeffect effect:REDSTONE at:<context.entity.location.add[0,0,0]> velocity:<context.entity.left.down.to_cuboid[<context.target.right.above>].blocks.parse[sub[<context.entity.location>].div[2]]> quantity:1 special_data:1|<color[54,32,53]>
    - playeffect effect:REDSTONE at:<context.entity.location.add[0,0,0]> velocity:<context.entity.left.down.to_cuboid[<context.target.right.above>].blocks.parse[sub[<context.entity.location>].div[2]]> quantity:1 special_data:1|<color[133,29,128]>
    - wait 2t

Green_Phantom_Breath:
  type: task
  debug: false
  script:
#KEY EVENT PURPOSEFULLY MISSING. TO BE CALLED BY A MOB
  - repeat 10:
    - playeffect effect:SNEEZE at:<context.entity.location.add[0,0,0]> velocity:<context.entity.left.down.to_cuboid[<context.target.right.above>].blocks.parse[sub[<context.entity.location>].div[2]]> quantity:4 special_data:SLIME_BLOCK
    - playeffect effect:REDSTONE at:<context.entity.location.add[0,0,0]> velocity:<context.entity.left.down.to_cuboid[<context.target.right.above>].blocks.parse[sub[<context.entity.location>].div[2]]> quantity:1 special_data:1|<color[12,197,6]>
    - playeffect effect:REDSTONE at:<context.entity.location.add[0,0,0]> velocity:<context.entity.left.down.to_cuboid[<context.target.right.above>].blocks.parse[sub[<context.entity.location>].div[2]]> quantity:1 special_data:1|<color[7,118,3]>
    - wait 2t
