Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # AUTH REDUCER
      # GET /users/:id -> user details (not used...)
      # POST /users -> find_or_create_by :google_id (add params as body in POST)
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      post '/google_oauth', to: 'auth#google_oauth'
      get '/profile', to: 'users#profile'

      # PLAYLIST REDUCER and RECENT EPISODES REDUCER
      # GET /episodes/:id -> episode detail (is this used???)
      # GET /episodes -> return episodes for playlist
      # POST /episodes/:episode_id/playlist -> add new episode to playlist
      # DELETE /episodes/:episode_id/playlist -> delete a a playlist by user_id and episode_id
      # GET /episodes/recent -> return recent episodes
      resources :episodes, only: [:index, :show] do
        post 'playlist', to: 'episodes#add_playlist'
        delete 'playlist', to: 'episodes#remove_playlist'
        collection do
          get 'recent'
        end
      end

      # SELECTED PODCAST REDUCER (show page) and SEARCH RESULTS REDUCER
      # GET /podcasts/:id -> podcast detail (+episode detail)
      # GET /podcasts/search/:term -> search
      
      # SUBSCIPTIONS REDUCER
      # GET /podcasts -> list of podcasts user is subscribed to (INSTEAD OF using /users/:user_id/subscriptions)
      # POST /podcasts/:podcast_id/subscription -> add new subscription 
      # DELETE /podcasts/:podcast_id/subscription -> delete a a playlist by user_id and episode_id
      resources :podcasts, only: [:show, :index] do
        post 'subscription', to: 'podcasts#subscribe'
        delete 'subscription', to: 'podcasts#unsubscribe'
        collection do
          get 'search/:term', to: 'podcasts#search'
        end
      end
        
    end
  end
end
