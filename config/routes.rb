Rails.application.routes.draw do

  devise_for :users

  resources :games, except: [:delete] do
    member do
      put :fire
    end
  end

  root 'games#new'
end
