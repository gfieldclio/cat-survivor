module Scenes::Game
  module Level
    def self.tick(args)
      init(args)
      render(args)
    end

    def self.init(args)
      return if args.state.level

      args.state.level.area = {
        x: 0,
        y: 0,
        w: LEVEL_MAX_X,
        h: LEVEL_MAX_Y,
      }
      args.state.level.terrain_type = Sprites::Terrain::Ground::FILE_MAP.keys.sample
    end

    def self.render(args)
      left_sprite = (args.state.camera.x / TERRAIN_SPRITE_SIZE) - 1
      right_sprite = left_sprite + (args.state.camera.w / TERRAIN_SPRITE_SIZE) + 2
      bottom_sprite = (args.state.camera.y / TERRAIN_SPRITE_SIZE) - 1
      top_sprite = bottom_sprite + (args.state.camera.h / TERRAIN_SPRITE_SIZE) + 2

      (left_sprite.to_i..right_sprite.to_i).each do |sprite_x|
        (bottom_sprite.to_i..top_sprite.to_i).each do |sprite_y|
          x = (sprite_x * TERRAIN_SPRITE_SIZE) - args.state.camera.x
          y = (sprite_y * TERRAIN_SPRITE_SIZE) - args.state.camera.y

          args.outputs.sprites << Sprites::Terrain::Ground.tile(
            x: x,
            y: y,
            type: args.state.level.terrain_type,
            key: "grass",
            side: "top",
          )
        end
      end
    end
  end
end
