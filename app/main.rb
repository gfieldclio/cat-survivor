require "app/constants"
require "app/sprites/sprites"
require "app/scenes/intro"
require "app/scenes/game"
require "app/scenes/game_over"
require "app/scenes/credits"
require "app/scenes/game/enemies/enemies"
require "app/scenes/game/player"
require "app/weapons/scratch"
require "app/weapons/laser"
require "app/weapons/feather"

def tick args
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]

  if args.state.scene.nil?
    args.state.scene = :intro
    args.audio[:bg_music] = { input: "audio/music/abstraction-sanctuary.ogg", looping: true, gain: 0.5 }
  end

  case args.state.scene
  when :intro
    Scenes::Intro.tick(args)
  when :game
    Scenes::Game.tick(args)
  when :game_over
    Scenes::GameOver.tick(args)
  when :credits
    Scenes::Credits.tick(args)
  end
end
