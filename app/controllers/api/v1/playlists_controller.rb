class Api::V1::PlaylistsController < ApplicationController
  before_action :current_user

  def index
    @playlists = @user.playlists
    render json: @playlists, include: "episode,episode.podcast"
  end

  def create
    byebug
    if params[:sort]
      my_params = playlist_params.merge(user_id: params[:user_id])
      @playlist = Playlist.create(my_params)
    else
      sort = @user.playlists.maximum(:sort) || 0
      my_params = playlist_params.merge(sort: sort + 1, user_id: params[:user_id])
      @playlist = Playlist.create(my_params)
    end
    if @playlist.valid?
      render json: @playlist, status: 201, include: "episode,episode.podcast"
    else
      render json: { errors: @playlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @playlist = Playlist.find_by(id: params[:id])
    @playlist.destroy
    render body: nil, status: :no_content
  end

  private

  def playlist_params
    params.require(:playlist).permit(:user_id, :episode_id, :sort)
  end

  def current_user
    @user = User.find_by(id: params[:user_id])
  end

end
