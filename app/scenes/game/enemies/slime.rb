module Scenes::Game
  module Enemies
    class Slime

      SPEED = 1

      def initialize(args)
        # todo: don't spawn enemies too close to player
        @x = rand(SCREEN_WIDTH)
        @y = rand(SCREEN_HEIGHT)
        render(args)
      end
      
      def move(args)
        # todo: get player coordinates via args
        player_x = 100
        player_y = 100

        @x = player_x > @x ? @x + SPEED : @x - SPEED
        @y = player_y > @y ? @y + SPEED : @y - SPEED

        render(args)
      end

      def render(args)
        args.outputs.sprites << Sprites::Slime.tile(x: @x, y: @y, type: "slime_walking", key: "still")
      end

    end
  end
end
