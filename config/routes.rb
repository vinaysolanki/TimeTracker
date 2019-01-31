Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :users, only: [] do
    resources :time_sheets, only: [:show] do
      member do
        post :toggle_timer
      end
    end
  end
end
