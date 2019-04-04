module FrameUtils
  extend ActiveSupport::Concern

  included do
    def valid_pins?(pins_number) # method that returns true if the number of pins is valid
      pins_number > pins_left or pins_number < 0 or pins_number > 10
    end

    def update_roll(pins_number)
      if first_roll.nil?
        self.first_roll = pins_number
      elsif second_roll.nil?
        self.second_roll = pins_number
      elsif last_frame_finished
        self.third_roll = pins_number
      end
    end

    def set_mark
      if first_roll == 10
        self.mark = 'strike'
      elsif !second_roll.nil? and first_roll + second_roll == 10
        self.mark = 'spare'
      end
    end

    def manage_score(pins_number)
      if get_frame(-1).is_strike? and get_frame(-2).is_strike?
        get_frame(-2).increment_score(pins_number) if second_roll.nil?
        get_frame(-1).increment_score(pins_number) if third_roll.nil?
      elsif get_frame(-1).is_strike? and third_roll.nil?
        get_frame(-1).increment_score(pins_number)
      elsif get_frame(-1).is_spare? and second_roll.nil?
        get_frame(-1).increment_score(pins_number)
      end
    end

    def last_frame_finished
      game.current_frame_number.eql?(10) and (is_strike? or is_spare?)
    end
  end
end
