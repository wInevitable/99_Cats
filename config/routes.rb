MyProjectName::Application.routes.draw do

  resources :cats
  resources :cat_rental_requests
  get '/cat_rental_requests/:id/approve', to: 'cat_rental_requests#approve!', as: 'approve_request'
  
  root to: 'cats#index'
end
