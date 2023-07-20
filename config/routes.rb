require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  resources :provider_supports
  resources :mihygge_supports
  resources :beds
  resources :wishlists
  resources :staff_roles
  resources :staff_details
  resources :room_services
  resources :room_service_types
  resources :room_types
  resources :rooms
  resources :subscriptions
  resources :plans
  resources :bookings
  resources :licences
  resources :facility_types
  resources :facilities
  resources :roles
  resources :users
  resources :services
  resources :newsletters
  resources :service_types
  resources :testimonials
  resources :podcasts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/docs', :to => redirect('doc/api/index.html')
  # Don't include devise as it restricts to load User modules
  post '/users/password', to: 'api/v1/passwords#create'
  put  '/users/password', to: 'api/v1/passwords#update'
  get  'reset_password', to: 'api/v1/passwords#edit', as: 'edit_password'
  namespace :api do
    api_version(
      module: 'v1',
      header: { name: 'Accept', value: 'application/json; version=1' },
      default: true
    ) do
      resources :mihygge_supports
      resources :users do
        collection do
          post :login
        end
        member do
          put :change_password
          get :confirm_email
          get :cares
          post :add_to_wishlist
          delete :remove_wishlist
          get :wishlists
          get :account_url
          get :bookings
        end
      end
      resources :roles
      resources :relationships
      resources :bookings do
        member do
          post :payment
          post :booking_rcfe_form
        end
      end
      resources :cards, only: [:destroy]
      resources :staff_roles
      resources :room_types
      resources :service_types do
        collection do
          get :services
        end
      end
      resources :facility_types
      resources :room_service_types
      resources :rooms do
        member do
          get :view_room
        end
        collection do
          get :view_filtered_room
          get :view_filtered_bed
        end
      end
      resources :passwords
      resources :cares do
        member do
          get :services
          get :view_care
        end
        collection do
          get :search
        end
      end
      resources :billings do
        collection do
          get :create_card_token
          post :subscribe
          put :update_card
          post :reattempt_payment
          post :cancel_subscription
          get :subscriptions_plan
          get :view_subscription
          get :retrieve_card_detail
          get :subscription_checkout
          post :add_bank_details
          post :add_bank_details_company
          get :show_bank_details
          post :webhook_event
          post :stripe_account_update
          post :set_care_plan
        end
      end
      resources :newsletters
      resources :appointments do
        collection do
          post :ask_for_demo
        end
      end
      resources :taxes
      resources :search do
        collection do
          get :autocomplete
        end
      end
      resources :checkers do
        collection do
          post :event_handler
          post :create_candidate
        end
      end
      resources :assets
      resources :documents do
        collection do
          post :signing
          post :testing
          get :ds_return
        end
      end

      resources :beds do
        collection do
          post :hold
        end
      end

      delete '/sessions/destroy', to: 'sessions#destroy'
    end
  end

  namespace :admin do
    mount Sidekiq::Web => '/sidekiq'
    resources :sessions, only: [:new, :create, :destroy]
    resources :passwords

    resources :providers, only: [:index, :edit, :update] do
      member do
        get 'update_docusign'
        get 'send_bankdetails_mail'
      end

      resources :comments, only: [:index]
    end

    resources :cares, only: [:index, :edit, :update] do
      member do
        get 'licences'
      end

      collection do
        get 'search'
      end
    end
  end

  get 'login', to: 'admin/sessions#new', as: 'login'
  delete 'logout', to: 'admin/sessions#destroy', as: 'logout'
  root 'admin/home#index'
  get 'documents/test', to: 'api/v1/documents#test'
end
