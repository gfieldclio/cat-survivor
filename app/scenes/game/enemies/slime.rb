module Scenes::Game
  module Enemies
    class Slime
      attr_accessor :x, :y

      SPEED = 1

      def initialize(args)
        # todo: don't spawn enemies too close to player
        @x = rand(SCREEN_WIDTH)
        @y = rand(SCREEN_HEIGHT)
        render(args)
      end
      
      def move(target_x, target_y, args)

        # todo: get the centre of the player so we don't need to do this
        target_x = target_x + 25
        target_y = target_y + 25

        angle = { x: target_x, y: target_y }.angle_from({ x: @x, y: @y }).to_radians
        @x += Math.cos(angle) * SPEED
        @y += Math.sin(angle) * SPEED

        render(args)
      end

      def render(args)
        args.outputs.sprites << Sprites::Slime.tile(x: @x, y: @y, type: "slime_walking", key: "still")
      end

      def serialize
        {
          x: @x,
          y: @y
        }
      end

      def inspect
        serialize.to_s
      end

      def to_s
        serialize.to_s
      end
    end
  end
end
