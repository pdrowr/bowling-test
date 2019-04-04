module GameUtils
  extend ActiveSupport::Concern

  included do
    def initialize_game
      10.times { frames.create }
    end

    def next_frame
      return unless current_frame.is_strike? or !current_frame.second_roll.nil?
      self.current_frame_number += 1
    end

    def finish_game
      return if !last_frame_finished
      self.finished = true
    end
  end
end
