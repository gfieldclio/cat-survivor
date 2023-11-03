module Scenes::Game
  module Player

    def self.take_damage(args, enemy)
      # puts enemy
      args.state.player.health -= enemy.damage
      if args.state.player.health < 0
        # death animation?
        args.state.scene = :game_over
        # args.state.scene = :intro
      end
    end

    def self.init(args)
      return if args.state.player.x

      args.state.player.x = args.grid.center_x.to_i
      args.state.player.y = args.grid.center_y.to_i
      args.state.player.cat_type = args.state.player.cat_type || "cat_6"
      tile_w, tile_h = Sprites::Player::TILE_SIZES[args.state.player.cat_type]
      args.state.player.w = tile_w * 2
      args.state.player.h = tile_h * 2
      args.state.player.anchor_x = 0.5
      args.state.player.anchor_y = 0.5
      args.state.player.key = "down_still"
      args.state.player.level = 1
      args.state.player.health = 500
      args.state.player.weapon = Weapons::Scratch
      args.state.player.selected_weapon = 0
    end

    def self.reset(args)
      args.state.player = nil
    end

    def self.toggle_on_iteration(args)
      if (args.tick_count/10).to_i % 2 == 0 && args.state.player.key[-1] == "1"
        args.state.player.key[-1] = "2"
      end
    end

    def self.handle_movement(args)
      update_position(args)
      render(args)
    end

    def self.update_position(args)
      dx, dy = if args.inputs.keyboard.left && args.inputs.keyboard.up
                 [-2, 2]
               elsif args.inputs.keyboard.left && args.inputs.keyboard.down
                 [-2, -2]
               elsif args.inputs.keyboard.right && args.inputs.keyboard.up
                 [2, 2]
               elsif args.inputs.keyboard.right && args.inputs.keyboard.down
                 [2, -2]
               elsif args.inputs.keyboard.left
                 [-3, 0]
               elsif args.inputs.keyboard.right
                 [3, 0]
               elsif args.inputs.keyboard.up
                 [0, 3]
               elsif args.inputs.keyboard.down
                 [0, -3]
               else
                 [0, 0]
               end

      on_blocking_tile =  args.state.level.blocking_tiles.any? { |tile| tile.intersect_rect?(args.state.player) }
      if on_blocking_tile
        args.state.player.x += dx
        args.state.player.y += dy
      else
        args.state.player.x += dx
        args.state.player.x -= dx if args.state.level.blocking_tiles.any? { |tile| tile.intersect_rect?(args.state.player) }
        args.state.player.y += dy
        args.state.player.y -= dy if args.state.level.blocking_tiles.any? { |tile| tile.intersect_rect?(args.state.player) }
      end
    end

    def self.render(args)
      args.state.player.key = if args.inputs.keyboard.left && args.inputs.keyboard.key_up.left
              "left_still"
            elsif args.inputs.keyboard.right && args.inputs.keyboard.key_up.right
              "right_still"
            elsif args.inputs.keyboard.up && args.inputs.keyboard.key_up.up
              "up_still"
            elsif args.inputs.keyboard.down && args.inputs.keyboard.key_up.down
              "down_still"
            elsif args.inputs.keyboard.left
              "left_walk_1"
            elsif args.inputs.keyboard.right
              "right_walk_1"
            elsif args.inputs.keyboard.up
              "up_walk_1"
            elsif args.inputs.keyboard.down
              "down_walk_1"
            else
              args.state.player.key
            end
      toggle_on_iteration(args)

      args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)
    end
  end
end
