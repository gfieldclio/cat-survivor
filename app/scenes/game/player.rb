module Scenes::Game
  module Player

    def self.render(args)
      args.state.player.x ||= 100
      args.state.player.y ||= 100
      args.state.player.key ||= "down_still"
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
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: args.state.player.key)
        if args.inputs.keyboard.key_up.left
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "left_still")
          args.state.player.key = "left_still"
        end
      elsif args.inputs.keyboard.right
        args.state.player.key = "right_walk_1"
        toggle_on_iteration(args)
        args.state.player.x += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: args.state.player.key)
        if args.inputs.keyboard.key_up.right
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "right_still")
          args.state.player.key = "right_still"
        end
      elsif args.inputs.keyboard.up
        args.state.player.key = "up_walk_1"
        toggle_on_iteration(args)
        args.state.player.y += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: args.state.player.key)
        if args.inputs.keyboard.key_up.up
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "up_still")
          args.state.player.key = "up_still"
        end
      elsif args.inputs.keyboard.down
        args.state.player.key = "down_walk_1"
        toggle_on_iteration(args)
        args.state.player.y -= 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: args.state.player.key)
        if args.inputs.keyboard.key_up.down
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "down_still")
          args.state.player.key = "down_still"
        end
      else
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: args.state.player.key)
      end
    end
  end
end