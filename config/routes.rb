ClarkTravel::Application.routes.draw do
  # resources :customers

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
  
  resources :password_resets, only: [:new, :edit, :update, :create]
  resources :german_cruising_registrations, only: [:new, :edit]
  
  resources :downloads, only: [:index]
  
  root to: "promotions#index"
  
  
  
  post "users/:id/contact_me", to: "users#send_contact_me_email", as: "user_contact_me"
  post "users/sort", to: "users#sort", as: "sort_users"
  post "promotions/sort", to: "promotions#sort", as: "sort_promotions"
  post "testimonials/sort", to: "testimonials#sort", as: "sort_testimonials"
  
  get 'session', to: redirect('/')
  get 'auth/:provider/callback', to: 'users#update_facebook_auth', as: "facebook_callback"
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
end
