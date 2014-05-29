MyProjectName::Application.routes.draw do
  
  resources :users, only: [:new, :create, :show]
  resource :session, :only => [:create, :destroy, :new]
  
  resources :cats
  resources :cat_rental_requests do
    member do
      put :approve 
      put :deny
    end
  end
  
  root to: 'cats#index'
end
