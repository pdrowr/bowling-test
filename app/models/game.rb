class Game < ApplicationRecord
  include GameUtils
  has_many :frames, dependent: :destroy
  after_create :initialize_game

  def current_frame
    frames[current_frame_number - 1]
  end

  def roll(pins_number)
    raise 'Game has finished.' if finished
    current_frame.roll(pins_number)
    current_frame_number < 10 ? next_frame : finish_game
    save
  end

  def last_frame_finished
    (current_frame.is_strike? and !current_frame.third_roll.nil?) or
    (current_frame.is_spare? and !current_frame.third_roll.nil?) or
    (!current_frame.is_strike? and !current_frame.is_spare? and !current_frame.second_roll.nil?)
  end

  def total_score
    frames.sum(&:score)
  end
end
