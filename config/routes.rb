Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :episodes, only: [:show]
      # GET /episodes/:id -> episode detail (is this used???)

      # SELECTED PODCAST REDUCER (show page) and SEARCH RESULTS REDUCER
      # GET /podcasts/:id -> podcast detail (+episode detail)
      # GET /podcasts/search/:term -> search
      resources :podcasts, only: [:show] do
        collection do
          get 'search/:term', to: 'podcasts#search'
        end
      end
        
      # AUTH REDUCER
      # GET /users/:id -> user details (not used...)
      # POST /users -> find_or_create_by :google_id (add params as body in POST)
      resources :users, only: [:create, :show] do
        post 'google/:token', to: 'users#google'
        
        # SUBSCIPTIONS REDUCER
        # GET /users/:user_id/podcasts -> list of podcasts user is subscribed to (INSTEAD OF using /users/:user_id/subscriptions)
        # POST /users/:user_id/podcasts/:podcast_id/subscription -> add new subscription 
        # DELETE /users/:user_id/podcasts/:podcast_id/subscription -> delete a a playlist by user_id and episode_id
        resources :podcasts, only: [:index] do
          post 'subscription', to: 'podcasts#subscribe'
          delete 'subscription', to: 'podcasts#unsubscribe'
        end

        # PLAYLIST REDUCER and RECENT EPISODES REDUCER
        # GET /users/:user_id/episodes -> return episodes for playlist
        # POST /users/:user_id/episodes/:episode_id/playlist -> add new episode to playlist
        # DELETE /users/:user_id/episodes/:episode_id/playlist -> delete a a playlist by user_id and episode_id
        # GET /users/:user_id/episodes/recent -> return recent episodes
        resources :episodes, only: [:index] do
          post 'playlist', to: 'episodes#add_playlist'
          delete 'playlist', to: 'episodes#remove_playlist'
          collection do
            get 'recent'
          end
        end

      end
    end
  end
end
