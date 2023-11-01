module Scenes::Game
  class Player

    attr_accessor :key
    def initialize(args)
      @x = 100
      @y = 100
      @key = "down_still"
    end

    # to add: changing animations
    # you can see what tick number is--as part of args it will have frame number, can do division with floor/ceiling to decide which one to do
    # could make it change frames every 10 ticks
    def handle_movement(args)
      if args.inputs.keyboard.key_down.left
        args.state.player.x -= 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "left_walk_1")
        args.state.player.key = "left_walk_1"
      elsif args.inputs.keyboard.key_down.right
        args.state.player.x += 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "right_walk_1")
        args.state.player.key = "right_walk_1"
      elsif args.inputs.keyboard.key_down.up
        args.state.player.y += 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "up_walk_1")
        args.state.player.key = "up_walk_1"
      elsif args.inputs.keyboard.key_down.down
        args.state.player.y -= 15
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: "down_walk_1")
        args.state.player.key = "down_walk_1"
      else
        args.outputs.sprites << Sprites::Player.tile(x: args.state.player.x, y: args.state.player.y, type: "cat_1", key: args.state.player.key)
      end
    end

    def render(args)
      # todo: update coordinates to move towards player
      # args.outputs.sprites << Sprites::Player.tile(x: 100, y: 100, type: "cat_1", key: "down_still")
      args.state.player.x ||= @x
      args.state.player.y ||= @y
      args.state.player.key ||= @key
    end
  end
end