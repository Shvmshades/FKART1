Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
    
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: 'sessions#destroy'
  post 'set_seller', to: 'sellers#set_seller'
  get 'seller_product', to: 'sellers#seller_product'
  get 'cart_product', to: 'carts#cart_product'
  get 'carts', to: 'users#carts'
  post 'remove_product', to: 'users#remove_cart_product'

  resources :categories do
    resources :products
  end

  resources :carts do 
    resources :products
  end

  
end
