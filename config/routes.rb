Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :admin do
        post "auth/login", to: "auth#login"
        post "auth/register", to: "auth#register"

        resources :brands, only: [:create] do
          member do
            put :update_status
          end
        end

        resources :products, only: [:create, :update, :destroy] do
          member do
            put :update_status
          end
        end

        resources :clients
        resources :client_products, only: [] do
          collection do
            post :bulk_assign
            delete :bulk_remove
          end
        end

        resources :reports, only: [] do
          collection do
            get :brands
            get :clients
          end
        end
      end

      namespace :clients do
        resources :products, only: [:index]
        resources :brands, only: [:index, :show]

        resources :gift_cards, only: [:create, :destroy]

        resources :reports, only: [] do
          collection do
            get :spending
            get :cancel
          end
        end
      end
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
