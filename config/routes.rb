Rails.application.routes.draw do
  
  resources :sites, only: [:index, :new, :create, :show]
end
