ClarkTravel::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resources :users
  resources :promotions
  root to: "promotions#index"
  
  # get 'pages/directions' => 'high_voltage/pages#directions', id: 'directions'
end
