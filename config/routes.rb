Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # devise_for :installs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
    
  
  post 'set_seller', to: 'sellers#set_seller'
  get 'seller_product', to: 'sellers#seller_product'

  get 'cart_product', to: 'carts#cart_product'
  get 'carts', to: 'carts#user_carts'
  post 'remove_product', to: 'carts#remove_cart_product'
  
  get 'search',to:'products#search'
  get '/card/new' => 'billing#new_card', as: :add_payment_method
  post "/card" => "billing#create_card", as: :create_payment_method
  get '/success' => 'billing#success', as: :success

  resources :registrations, only: [:new, :create,:show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :passwords, only: [:edit,:update]
  resources :billing, only: [:index]

  resources :categories do
    member do
      get :product_by_category
    end
    resources :products
  end

  resources :carts do
    resources :products
  end

  resources :registrations do
    member do
      get :confirm_email
      patch :update_token
      get :show_user
    end
  end

end