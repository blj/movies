Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "features#index"
  resources :features, only: %i{index show}
  resources :people, only: %i{index show}
end
