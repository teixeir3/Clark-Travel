ClarkTravel::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users do
    get :activate, on: :collection
    get :password_reset, on: :collection
    put :password_update, on: :collection
  end
  resources :promotions, :testimonials
  resources :booking_categories do
    resources :bookings
  end
  
  resources :bookings
  
  resources :downloads, only: [:index]
  
  root to: "promotions#index"
  
  
  post "users/sort", to: "users#sort", as: "sort_users"
  post "promotions/sort", to: "promotions#sort", as: "sort_promotions"
  post "testimonials/sort", to: "testimonials#sort", as: "sort_testimonials"
  
  get 'session', to: redirect('/')
  get 'auth/:provider/callback', to: 'sessions#update_facebook_auth'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
end
