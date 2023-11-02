module Scenes::Game
  module Level
    LEVEL_WIDTH = 1000
    LEVEL_HEIGHT = 1000
    LEVEL_MAX_X = LEVEL_WIDTH * Sprites::Terrain::SPRITE_SIZE
    LEVEL_MAX_Y = LEVEL_HEIGHT * Sprites::Terrain::SPRITE_SIZE

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
      args.state.level.camera = {
        x: LEVEL_MAX_X / 2 - SCREEN_WIDTH,
        y: LEVEL_MAX_Y / 2 - SCREEN_HEIGHT,
        w: SCREEN_WIDTH,
        h: SCREEN_HEIGHT,
      }
      args.state.level.terrain_type = Sprites::Terrain::Ground::FILE_MAP.keys.sample
    end

    def self.render(args)
      left_sprite = (args.state.level.camera.x / Sprites::Terrain::SPRITE_SIZE) - 1
      right_sprite = left_sprite + (args.state.level.camera.w / Sprites::Terrain::SPRITE_SIZE) + 2
      bottom_sprite = (args.state.level.camera.y / Sprites::Terrain::SPRITE_SIZE) - 1
      top_sprite = bottom_sprite + (args.state.level.camera.h / Sprites::Terrain::SPRITE_SIZE) + 2

      (left_sprite.to_i..right_sprite.to_i).each do |sprite_x|
        (bottom_sprite.to_i..top_sprite.to_i).each do |sprite_y|
          x = (sprite_x * Sprites::Terrain::SPRITE_SIZE) - args.state.level.camera.x
          y = (sprite_y * Sprites::Terrain::SPRITE_SIZE) - args.state.level.camera.y

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
