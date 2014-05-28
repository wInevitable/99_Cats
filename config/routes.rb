MyProjectName::Application.routes.draw do

  resources :cats
  resources :cat_rental_requests
  
  put '/cat_rental_requests/:id/approve', to: 'cat_rental_requests#approve!', as: 'approve_request' 
  put '/cat_rental_requests/:id/deny', to: 'cat_rental_requests#deny!', as: 'deny_request'
  
  root to: 'cats#index'
end
