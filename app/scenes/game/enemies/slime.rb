module Scenes::Game
  module Enemies
    class Slime
      attr_accessor :x, :y, :health

      STARTING_HEALTH = 300.freeze
      SPEED = 1.freeze
      DAMAGE = 10.freeze

      def initialize(args)
        # todo: don't spawn enemies too close to player
        @x = rand(SCREEN_WIDTH)
        @y = rand(SCREEN_HEIGHT)
        @health = STARTING_HEALTH
        render(args)
      end
      
      def move(target_x, target_y, args)
        return render_death(args) if dead?

        # todo: get the centre of the player so we don't need to do this
        target_x = target_x + 25
        target_y = target_y + 25

        angle = { x: target_x, y: target_y }.angle_from({ x: @x, y: @y }).to_radians
        @x += Math.cos(angle) * SPEED
        @y += Math.sin(angle) * SPEED

        render(args)
      end

      def take_damage(damage, args)
        @health -= damage
        render_death(args) if dead?
      end

      def dead?
        @health < 0
      end

      def render_death(args)
        #todo 
        nil
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
