module Scenes::Game
  module Enemies
    class Orc
      attr_accessor :x, :y, :w, :h, :health, :started_running_at, :started_dying_at, :damage

      STARTING_HEALTH = 1250.freeze
      SPEED = 2.30.freeze
      STARTING_DAMAGE = 10.freeze

      def initialize(args)
        set_starting_position(args)
        @health = STARTING_HEALTH
        @damage = STARTING_DAMAGE
        @w = 45
        @h = 45
        @started_running_at = args.tick_count
        @current_direction = "side"
        @flip_horizontally = false
        render(args, "side_walking", @flip_horizontally)
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

        @x += x_vector
        @y += y_vector

        if y_vector < 0 && x_vector.abs < y_vector.abs
          @started_running_at = args.tick_count if @current_direction != "down"
          @flip_horizontally = false
          render(args, "down_walking", @flip_horizontally)
          @current_direction = "down"
        elsif y_vector > 0 && x_vector.abs < y_vector.abs
          @started_running_at = args.tick_count if @current_direction != "up"
          @flip_horizontally = false
          render(args, "up_walking", @flip_horizontally)
          @current_direction = "up"
        elsif x_vector > 0
          @started_running_at = args.tick_count if @current_direction != "side" && !@flip_horizontally
          @flip_horizontally = true
          render(args, "side_walking", @flip_horizontally)
          @current_direction = "side"
        else
          @started_running_at = args.tick_count if @current_direction != "side" && @flip_horizontally
          @flip_horizontally = false
          render(args, "side_walking", @flip_horizontally)
          @current_direction = "side"
        end

        
      end

      def dying_in_progress?(args)
        tile = Sprites::Orc.tile(orc: self, x: @x, y: @y, type: "#{@current_direction}_dying", flip_horizontally: @flip_horizontally)
        return false if tile.nil?
        args.outputs.sprites << tile
        true
      end

      def take_damage(args, damage)
        @health -= damage
        @started_dying_at = args.tick_count if dead?
      end

      def dead?
        @health < 0
      end

      def render(args, type, flip_horizontally = false)
        args.outputs.sprites << Sprites::Orc.tile(orc: self, x: @x, y: @y, type: type, flip_horizontally: flip_horizontally)
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
