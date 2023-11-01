module Scenes::Game
  module PlayerMovement
    # to add: changing animations
    def self.tick(args)
      if args.inputs.keyboard.key_down.left
        puts args.state.player.x
        args.state.player.x -= 5
      elsif args.inputs.keyboard.key_down.right
        puts args.state.player.x
        args.state.player.x += 5
      elsif args.inputs.keyboard.key_down.up
        puts args.state.player.y
        args.state.player.y += 5
      elsif args.inputs.keyboard.key_down.down
        puts args.state.player.y
        args.state.player.y -= 5
      end
    end
  end
end