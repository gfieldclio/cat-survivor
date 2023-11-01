module Scenes
  module Game
    def self.tick(args)
      render_background(args)
    end

    def self.render_background(args)
      args.outputs.sprites << Sprites::Terrain.tile(x: 50, y: 50, type: "hills", key: "ground")
    end
  end
end
