module Scenes::Game
  module Player
    # diagonal movement
    def self.render(args)
      args.state.player.x ||= args.grid.center_x
      args.state.player.y ||= args.grid.center_y
      args.state.player.key ||= "down_still"
      args.state.player.cat_type ||= "cat_6"
    end

    def self.toggle_on_iteration(args)
      if (args.tick_count/10).to_i % 2 == 0 && args.state.player.key[-1] == "1"
        args.state.player.key[-1] = "2"
      end
    end

    def self.handle_movement(args)
      dx = 0
      dy = 0

      if args.inputs.keyboard.left
        args.state.player.key = "left_walk_1"
        toggle_on_iteration(args)
        dx -= 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)
        if args.inputs.keyboard.key_up.left
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "left_still")
          args.state.player.key = "left_still"
        end
      elsif args.inputs.keyboard.right
        args.state.player.key = "right_walk_1"
        toggle_on_iteration(args)
        dx += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)
        if args.inputs.keyboard.key_up.right
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "right_still")
          args.state.player.key = "right_still"
        end
      elsif args.inputs.keyboard.up
        args.state.player.key = "up_walk_1"
        toggle_on_iteration(args)
        dy += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)
        if args.inputs.keyboard.key_up.up
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "up_still")
          args.state.player.key = "up_still"
        end
      elsif args.inputs.keyboard.down
        args.state.player.key = "down_walk_1"
        toggle_on_iteration(args)
        dy -= 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)
        if args.inputs.keyboard.key_up.down
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: "down_still")
          args.state.player.key = "down_still"
        end
      else
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: args.state.player.cat_type, key: args.state.player.key)
      end

      if args.state.player.x + dx < 100 || args.state.player.x + dx > SCREEN_WIDTH - 100
        args.state.level.camera.x += dx
      else
        args.state.player.x += dx
      end
      if args.state.player.y + dy < 100 || args.state.player.y + dy > SCREEN_HEIGHT - 100
        args.state.level.camera.y += dy
      else
        args.state.player.y += dy
      end
    end
  end
end
