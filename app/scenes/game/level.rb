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
          render_tile(args, sprite_x, sprite_y)
        end
      end
    end

    def self.render_tile(args, sprite_x, sprite_y)
      x = (sprite_x * TERRAIN_SPRITE_SIZE) - args.state.camera.x
      y = (sprite_y * TERRAIN_SPRITE_SIZE) - args.state.camera.y

      args.outputs.sprites << Sprites::Terrain::Ground.tile(
        x: x,
        y: y,
        type: args.state.level.terrain_type,
        key: "grass"
      )

      if sprite_x % 25 == 0 && sprite_y % 25 == 0
        args.outputs.sprites << Sprites::Terrain::Rocks.tile(
          x: x,
          y: y,
          type: args.state.level.terrain_type,
          key: "rock#{sprite_x % 2 + 1}"
        )
      elsif (sprite_x + 10) % 25 == 0 && (sprite_y + 10) % 25 == 1
        args.outputs.sprites << Sprites::Terrain::Bushes.tile(
          x: x,
          y: y,
          type: args.state.level.terrain_type,
          key: sprite_x % 2 == 0 ? "bush" : "bush_flowers",
        )
      end
    end
  end
end
