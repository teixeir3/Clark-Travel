ClarkTravel::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users, :promotions, :testimonials
  root to: "promotions#index"
  
  
  post "users/sort", to: "users#sort", as: "sort_users"
  post "promotions/sort", to: "promotions#sort", as: "sort_promotions"
  post "testimonials/sort", to: "testimonials#sort", as: "sort_testimonials"
  
  get 'auth/:provider/callback', to: 'sessions#update_facebook_auth'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
end
