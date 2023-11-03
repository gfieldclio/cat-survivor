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
      args.state.level.tree_seed = rand(100_000)
      args.state.level.rock_seed = rand(100_000)
      args.state.level.bush_seed = rand(100_000)
      args.state.level.terrain_type = Sprites::Terrain::Ground::FILE_MAP.keys.sample
    end

    def self.reset(args)
      args.state.level = nil
    end

    def self.render(args)
      left_sprite = (args.state.camera.x / TERRAIN_SPRITE_SIZE) - 1
      right_sprite = left_sprite + (args.state.camera.w / TERRAIN_SPRITE_SIZE) + 2
      bottom_sprite = (args.state.camera.y / TERRAIN_SPRITE_SIZE) - 1
      top_sprite = bottom_sprite + (args.state.camera.h / TERRAIN_SPRITE_SIZE) + 2

      args.state.level.blocking_tiles = []

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

      blocking = render_tree(args, sprite_x, sprite_y, x, y) ||
        render_bush(args, sprite_x, sprite_y, x, y) ||
        render_rock(args, sprite_x, sprite_y, x, y)

      if blocking
        args.state.level.blocking_tiles << {
          x: x,
          y: y,
          w: TERRAIN_SPRITE_SIZE,
          h: TERRAIN_SPRITE_SIZE,
        }
      end
    end

    def self.render_tree(args, sprite_x, sprite_y, x, y)
      return false unless sprite_x % 50 < 16 && sprite_y % 40 < 12

      left = sprite_x - sprite_x % 50
      right = left + 15
      bottom = sprite_y - sprite_y % 40
      top = bottom + 11
      r = Random.new(args.state.level.tree_seed * left * bottom)

      return false if r.rand(3) == 0

      piece = if sprite_x == left && sprite_y % 2 == 0
                "bottom_left"
              elsif sprite_x == left && sprite_y % 2 == 1
                "top_left"
              elsif sprite_x == right && sprite_y % 2 == 0
                "bottom_right"
              elsif sprite_x == right && sprite_y % 2 == 1
                "top_right"
              elsif sprite_y == bottom && sprite_x % 2 == 0
                "bottom_left"
              elsif sprite_y == bottom && sprite_x % 2 == 1
                "bottom_right"
              elsif sprite_y == top && sprite_x % 2 == 0
                "top_left"
              elsif sprite_y == top && sprite_x % 2 == 1
                "top_right"
              elsif sprite_x % 2 == 0 && sprite_y % 2 == 0
                "forest_bottom_left"
              elsif sprite_x % 2 == 1 && sprite_y % 2 == 0
                "forest_bottom_right"
              elsif sprite_x % 2 == 0 && sprite_y % 2 == 1
                "forest_top_left"
              elsif sprite_x % 2 == 1 && sprite_y % 2 == 1
                "forest_top_right"
              end

      args.outputs.sprites << Sprites::Terrain::Trees.tile(
        x: x,
        y: y,
        type: args.state.level.terrain_type,
        key: r.rand(2) == 0 ? "tree1" : "tree2",
        piece: piece
      )
      true
    end

    def self.render_bush(args, sprite_x, sprite_y, x, y)
      r = Random.new(args.state.level.bush_seed * sprite_x * sprite_y)
      return false unless r.rand(25) % 25 == 0

      args.outputs.sprites << Sprites::Terrain::Bushes.tile(
        x: x,
        y: y,
        type: args.state.level.terrain_type,
        key: r.rand.round == 0 ? "bush" : "bush_flowers",
      )
      true
    end

    def self.render_rock(args, sprite_x, sprite_y, x, y)
      r = Random.new(args.state.level.rock_seed * sprite_x * sprite_y)
      return false unless r.rand(25) % 25 == 0

      args.outputs.sprites << Sprites::Terrain::Rocks.tile(
        x: x,
        y: y,
        type: args.state.level.terrain_type,
        key: "rock#{r.rand.round + 1}"
      )
      true
    end
  end
end
