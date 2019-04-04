module GamesHelper
  def frame_rolls(frame)
    render 'games/partials/frames_rolls', frame: frame
  end

  def frame_score(frame)
    render 'games/partials/frames_score', frame: frame
  end

  def messages
    render 'games/partials/messages'
  end
end
