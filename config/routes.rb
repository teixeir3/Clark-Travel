ClarkTravel::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users, :promotions, :testimonials
  root to: "promotions#index"
  
  post "users/sort", to: "users#sort", as: "sort_users"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
end
