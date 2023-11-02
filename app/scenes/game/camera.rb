module Scenes
  module Game
    module Camera
      EDGE_BUFFER = 200

      def self.tick(args)
        init(args)
        update_positions(args)
      end

      def self.init(args)
        return unless args.state.camera.nil?

        args.state.camera = {
          x: (LEVEL_MAX_X / 2 - SCREEN_WIDTH).to_i,
          y: (LEVEL_MAX_Y / 2 - SCREEN_HEIGHT).to_i,
          w: SCREEN_WIDTH,
          h: SCREEN_HEIGHT,
          dx: 0,
          dy: 0,
        }
      end

      def self.update_positions(args)
        return unless args.state.player.x

        args.state.camera.dx = calculate_delta(args.state.player.x, SCREEN_WIDTH)
        args.state.camera.dy = calculate_delta(args.state.player.y, SCREEN_HEIGHT)

        args.state.camera.x += args.state.camera.dx
        args.state.camera.y += args.state.camera.dy

        args.state.player.x -= args.state.camera.dx
        args.state.player.y -= args.state.camera.dy
        args.state.enemies.each do |enemy|
          enemy.x -= args.state.camera.dx
          enemy.y -= args.state.camera.dy
        end
      end

      def self.calculate_delta(value, max_value)
        if value < EDGE_BUFFER
          value - EDGE_BUFFER
        elsif value > max_value - EDGE_BUFFER
          value - (max_value - EDGE_BUFFER)
        else
          0
        end
      end
    end
  end
end
