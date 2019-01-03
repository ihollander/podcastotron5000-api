class Api::V1::EpisodesController < ApplicationController
  before_action :find_episode, only: :show
  before_action :find_episode_by_episode_id, only: [:add_playlist, :remove_playlist]
  before_action :current_user, only: [:index, :add_playlist, :remove_playlist, :recent]

  # GET /episodes/:id 
  def show
    if @episode
      render json: @episode
    else
      render json: { message: "Not found" }, status: :not_found 
    end
  end

  # GET /users/:user_id/episodes
  def index
    @episodes = @user.episodes
    render json: @episodes 
  end

  # POST /users/:user_id/episodes/:episode_id/playlist
  def add_playlist
    @playlist = @user.playlists.create(episode: @episode)
    if @playlist.valid?
      render json: @episode, status: :created
    else
      render json: { errors: @playlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/episodes/:episode_id/playlist
  def remove_playlist
    playlist = Playlist.find_by(user: @user, episode: @episode)
    if playlist
      playlist.destroy
      render body: nil, status: :no_content
    else
      render json: { message: "Playlist not found" }, status: :not_found  
    end
  end

  # GET /users/:user_id/episodes/recent
  def recent
    page = params[:page] || 1
    @user.podcasts.each do |podcast|
      podcast.update_feed # get latest
    end
    @episodes = Episode.by_user(@user).recent().page(page).per(25)
    response.headers['Paging-Last-Page'] = Episode.by_user(@user).page(page).last_page?
    render json: @episodes
  end

  private 

  def find_episode
    @episode = Episode.find_by(id: params[:id])
  end

  def find_episode_by_episode_id
    @episode = Episode.find_by(id: params[:episode_id])
  end
  
  def current_user
    @user = User.find_by(id: params[:user_id])
  end
end
