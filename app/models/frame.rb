class Frame < ApplicationRecord
  belongs_to :game
  include FrameUtils

  def roll(pins_number)
    raise 'Invalid roll.' if valid_pins?(pins_number)
    update_roll(pins_number)
    set_mark
    set_pins_left(pins_number)
    set_score(pins_number)
    self.save
  end

  def get_frame(shift) # method to find a specific frame
    game.frames[game.current_frame_number - 1 + shift]
  end

  def increment_score(score)
    self.score += score
    self.save
  end

  def set_score(pins_number)
    self.increment_score(pins_number)
    manage_score(pins_number)
  end

  def is_strike? #method that returns true if roll is a strike
    self.mark.eql?('strike')
  end

  def is_spare? #method that returns true if roll is a spare
    self.mark == 'spare'
  end

  def set_pins_left(pins_number) # method to set the quantity of pins left
    self.pins_left -= pins_number
    self.pins_left = 10 if last_frame_finished
  end

end
