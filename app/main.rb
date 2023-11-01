require "app/constants"
require "app/scenes/intro"
require "app/scenes/game"
require "app/scenes/game/enemies/slime"
require "app/sprites/terrain"
require "app/sprites/player"
require "app/sprites/slime"
require "app/enemies/slime"
require "app/scenes/game/player"

def tick args
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]

  if args.state.scene.nil?
    args.state.scene = :intro
  end

  if args.inputs.keyboard.key_down.space
    args.state.scene = args.state.scene == :intro ? :game : :intro
  end

  case args.state.scene
  when :intro
    Scenes::Intro.tick(args)
  when :game
    Scenes::Game.tick(args)
  end
end
