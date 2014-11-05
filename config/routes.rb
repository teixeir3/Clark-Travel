ClarkTravel::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users, :promotions
  root to: "promotions#index"
  
  post "users/sort", to: "users#sort", as: "sort_users"
  # get 'pages/directions' => 'high_voltage/pages#directions', id: 'directions'
end
