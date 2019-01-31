Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :time_sheets, only: [] do
    member do
      post :start_entry
      post :stop_entry
    end
  end
end
