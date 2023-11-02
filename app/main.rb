require "app/constants"
require "app/sprites/sprites"
require "app/scenes/intro"
require "app/scenes/game"
require "app/scenes/game/enemies/slime"
require "app/scenes/game/player"
require "app/weapons/scratch"
require "app/weapons/laser"
require "app/weapons/feather"

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
