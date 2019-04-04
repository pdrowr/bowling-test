Rails.application.routes.draw do
  root 'games#index'
  get 'new_game', to: 'games#new', as: :new_game
  get 'play_game/:game_id', to: 'games#play_game', as: :play_game
  post 'make_roll/:game_id', to: 'games#make_roll', as: :make_roll
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
