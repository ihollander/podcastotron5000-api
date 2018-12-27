Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show] do
        resources :subscriptions, only: [:create, :index, :destroy, :show]
      end
      resources :podcasts do
        collection do
          get 'search'
        end
      end
    end
  end
end
