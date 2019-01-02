class Api::V1::PodcastsController < ApplicationController
  before_action :find_podcast, only: :show
  before_action :current_user

  def search
    @podcasts = Podcast.find_or_create_from_api(params[:term])
    render json: @podcasts, each_serializer: PodcastSearchSerializer
  end

  def index
    @podcasts = @user.podcasts.order(:name)
    render json: @podcasts, each_serializer: PodcastSearchSerializer
  end

  def show
    if @podcast
      @podcast.update_feed 
      render json: @podcast, include: "genres,subscriptions,episodes,episodes.playlists"
    else
      render json: { message: "Not found" }, status: :not_found 
    end
  end

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

  def find_podcast
    @podcast = Podcast.find_by(slug: params[:id])
  end

  def current_user
    @user = User.find_by(id: params[:user_id])
  end

end
