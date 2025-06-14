Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "static_pages#top"
  resources :users, only: %i[new create]
  resources :shopping_lists do
    post :add_item, on: :collection
    patch :update_status, on: :member
  end
  
  resources :shopping_list_items, only: [ :update ]
  resources :purchase_histories
  resources :items do
    collection do
      get :autocomplete
    end
  end
  resources :purchase_histories, only: %i[create index]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
end
