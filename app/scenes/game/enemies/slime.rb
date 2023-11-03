module Scenes::Game
  module Enemies
    class Slime
      attr_accessor :x, :y, :w, :h, :health, :started_running_at, :started_dying_at, :damage

      STARTING_HEALTH = 300.freeze
      SPEED = 2.freeze
      STARTING_DAMAGE = 5.freeze

      def initialize(args)
        set_starting_position(args)
        @health = STARTING_HEALTH
        @damage = STARTING_DAMAGE
        @w = 32
        @h = 32
        @started_running_at = args.tick_count
        render(args, "walking")
      end

      def set_starting_position(args)
        radius = 170
        @x = rand(SCREEN_WIDTH)
        @y = rand(SCREEN_HEIGHT)

        if (@x - args.state.player.x).abs < radius
          @x = @x > args.state.player.x ? @x + radius : @x - radius
        end

        if (@y - args.state.player.y).abs < radius
          @y = @y > args.state.player.y ? @y + radius : @y - radius
        end
      end

      def move(args, target_x, target_y)
        return animate_dying(args) if dead?

        angle = { x: target_x, y: target_y }.angle_from({ x: @x, y: @y }).to_radians
        x_vector = Math.cos(angle) * SPEED
        y_vector = Math.sin(angle) * SPEED

        on_blocking_tile =  args.state.level.blocking_tiles.any? { |tile| tile.intersect_rect?(self) }
        if on_blocking_tile
          @x += x_vector
          @y += y_vector
        else
          @x += x_vector
          @x -= x_vector if args.state.level.blocking_tiles.any? { |tile| tile.intersect_rect?(self) }
          @y += y_vector
          @y -= y_vector if args.state.level.blocking_tiles.any? { |tile| tile.intersect_rect?(self) }
        end

        render(args, "walking")
      end

      def dying_in_progress?(args)
        tile = Sprites::Slime.tile(slime: self, x: @x, y: @y, type: "dying")
        return false if tile.nil?
        args.outputs.sprites << tile
        true
      end

      def take_damage(args, damage)
        # puts damage
        @health -= damage
        @started_dying_at = args.tick_count if dead?
      end

      def dead?
        @health < 0
      end

      def render(args, type)
        args.outputs.sprites << Sprites::Slime.tile(slime: self, x: @x, y: @y, type: type)
      end

      def serialize
        {
          x: @x,
          y: @y,
          w: @w,
          h: @h
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
