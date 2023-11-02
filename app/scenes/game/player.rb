module Scenes::Game
  module Player

    def self.render(args)
      args.state.player.x ||= 100
      args.state.player.y ||= 100
      args.state.player.key ||= "down_still"
    end
    # currently x and y is pointing to the corner of the sprite, figure out how to make it middle and then I can do screen height div 2 and screen width div 2 to get character to start in the middle
    # make not a class

    # to add: changing animations
    # you can see what tick number is--as part of args it will have frame number, can do division with floor/ceiling to decide which one to do
    # could make it change frames every 10 args.tick_count
    def self.handle_movement(args)
      if args.inputs.keyboard.left
        args.state.player.x -= 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "left_walk_1")
        args.state.player.key = "left_walk_1"
        if args.inputs.keyboard.key_up.left
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "left_still")
          args.state.player.key = "left_still"
        end
      elsif args.inputs.keyboard.right
        args.state.player.x += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "right_walk_1")
        args.state.player.key = "right_walk_1"
        if args.inputs.keyboard.key_up.right
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "right_still")
          args.state.player.key = "right_still"
        end
      elsif args.inputs.keyboard.up
        args.state.player.y += 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "up_walk_1")
        args.state.player.key = "up_walk_1"
        if args.inputs.keyboard.key_up.up
          args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "up_still")
          args.state.player.key = "up_still"
        end
      elsif args.inputs.keyboard.down
        args.state.player.y -= 3
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "down_walk_1")
        args.state.player.key = "down_walk_1"
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