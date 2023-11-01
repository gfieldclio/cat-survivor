module Enemies
  class Slime
  
    def initialize(args)
      @x = rand(SCREEN_WIDTH)
      @y = rand(SCREEN_HEIGHT)
    end

    def render(args)
      # todo: update coordinates to move towards player 
      args.outputs.sprites << Sprites::Slime.tile(x: @x, y: @y, type: "slime_walking", key: "still")
    end
  end
end