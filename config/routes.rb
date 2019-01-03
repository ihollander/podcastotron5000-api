Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/google_signin/:google_id', to: 'users#google_signin'
      delete 'remove_subscription/:podcast_id', to: 'users#remove_subscription'
      delete 'remove_playlist/:episode_id', to: 'users#remove_playlist'
      resources :episodes, only: [:show]
      resources :users, only: [:create, :show] do
        resources :playlists, only: [:index, :create, :update, :destroy]
        resources :subscriptions, only: [:create, :index, :destroy, :show]
        resources :podcasts, only: [:show, :index] do
          collection do
            get 'search'
            get 'recent'
          end
        end
      end
    end
  end
end
