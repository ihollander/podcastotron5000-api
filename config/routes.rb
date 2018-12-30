Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/google_signin/:google_id', to: 'users#google_signin'
      resources :users, only: [:create, :show] do
        resources :subscriptions, only: [:create, :index, :destroy, :show]
        resources :podcasts, only: [:show, :index] do
          collection do
            get 'search'
            get 'recent'
          end
          resources :episodes, only: [:index]
        end
      end
    end
  end
end
