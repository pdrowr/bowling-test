class Frame < ApplicationRecord
  belongs_to :game

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

  private

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
