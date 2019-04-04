class GamesController < ApplicationController
  before_action :set_game, only: %i[play_game make_roll]

  def index; end

  def new
    @game = Game.new

    if @game.save
      redirect_to play_game_path(@game)
    end
  end

  def play_game
  end

  def make_roll
    begin
      @game.roll(params[:number_of_pins].to_i)
    rescue Exception => exception
      flash[:notice] = exception.message
    end
    redirect_to play_game_path(@game)
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end
end
