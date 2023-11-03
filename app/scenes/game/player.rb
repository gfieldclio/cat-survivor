module Scenes::Game
  module Player

    def self.take_damage(args, enemy)
      # puts enemy
      args.state.player.health -= 5 # replace with whatever damage diff enemies do
      puts args.state.player.health
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
      args.state.player.w = Sprites::Player::SPRITE_WIDTH
      args.state.player.h = Sprites::Player::SPRITE_HEIGHT
      args.state.player.anchor_x = 0.5
      args.state.player.anchor_y = 0.5
      args.state.player.key = "down_still"
      args.state.player.cat_type = args.state.player.cat_type || "cat_6"
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
      if args.inputs.keyboard.left
        args.state.player.key = "left_walk_1"
        toggle_on_iteration(args)
        args.state.player.x -= 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)

        if args.inputs.keyboard.key_up.left
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "left_still")
          args.state.player.key = "left_still"
        end

        if args.inputs.keyboard.down
          args.state.player.y -= 2
          args.state.player.x += 1
        end
        if args.inputs.keyboard.up
          args.state.player.y += 2
          args.state.player.x += 1
        end
      elsif args.inputs.keyboard.right
        args.state.player.key = "right_walk_1"
        toggle_on_iteration(args)
        args.state.player.x += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)

        if args.inputs.keyboard.key_up.right
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "right_still")
          args.state.player.key = "right_still"
        end

        if args.inputs.keyboard.down
          args.state.player.y -= 2
          args.state.player.x -= 1
        end
        if args.inputs.keyboard.up
          args.state.player.y += 2
          args.state.player.x -= 1
        end
      elsif args.inputs.keyboard.up
        args.state.player.key = "up_walk_1"
        toggle_on_iteration(args)
        args.state.player.y += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)

        if args.inputs.keyboard.key_up.up
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "up_still")
          args.state.player.key = "up_still"
        end
      elsif args.inputs.keyboard.down
        args.state.player.key = "down_walk_1"
        toggle_on_iteration(args)
        args.state.player.y -= 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)

        if args.inputs.keyboard.key_up.down
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "down_still")
          args.state.player.key = "down_still"
        end
      else
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)
      end
    end
  end
end