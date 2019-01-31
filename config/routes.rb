Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new'
  end
  
  root to: 'time_sheets#show'

  resources :users, only: [] do
    resources :time_sheets, only: [:show] do
      member do
        post :toggle_timer
      end
    end
  end
end
