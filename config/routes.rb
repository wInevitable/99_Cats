MyProjectName::Application.routes.draw do

  resources :cats
  resources :cat_rental_requests
  
  root to: 'cats#index'
end
