module Scenes::Game
  class Player

    def initialize(args)
      @x = 100
      @y = 100
    end

    # to add: changing animations
    def handle_movement(args)
      if args.inputs.keyboard.key_down.left
        puts args.state.player.x
        args.state.player.x -= 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "left_walk_1")
      elsif args.inputs.keyboard.key_down.right
        puts args.state.player.x
        args.state.player.x += 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "right_walk_1")
      elsif args.inputs.keyboard.key_down.up
        puts args.state.player.y
        args.state.player.y += 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "up_walk_1")
      elsif args.inputs.keyboard.key_down.down
        puts args.state.player.y
        args.state.player.y -= 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "down_walk_1")
      else
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "down_still")
      end
    end

    def render(args)
      # todo: update coordinates to move towards player
      # args.outputs.sprites << Sprites::Player.tile(x: 100, y: 100, type: "cat_1", key: "down_still")
      args.state.player.x ||= @x
      args.state.player.y ||= @y
    end
  end
end