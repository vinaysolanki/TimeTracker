Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :users, only: [] do
    resources :time_sheets, only: [:show] do
      member do
        post :start_entry
        post :stop_entry
      end
    end
  end
end
