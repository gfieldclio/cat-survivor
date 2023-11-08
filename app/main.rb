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
  # if the keyboard doesn't have focus, and it isn't the first tick
  if !args.inputs.keyboard.has_focus && args.state.tick_count != 0
    args.outputs.background_color = [0, 0, 0]
    args.outputs.labels << {
      x: 640,
      y: 360,
      text: "Game Paused (click to resume).",
      size_enum: 10,
      alignment_enum: 1,
      r: 255,
      g: 255,
      b: 255,
      font: "fonts/Abaddon_Bold.ttf"
    }
    args.audio[:bg_music].paused = true
  else
    args.audio[:bg_music].paused = false

    # perform your regular tick function
    args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]

    if args.state.scene.nil?
      args.state.scene = :intro
      args.audio[:bg_music] = { input: "audio/music/abstraction-sanctuary.ogg", looping: true, gain: 0.1 }
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
end
