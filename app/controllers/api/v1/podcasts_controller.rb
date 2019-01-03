class Api::V1::PodcastsController < ApplicationController
  before_action :find_podcast_by_slug, only: :show
  before_action :find_podcast_by_id, only: [:subscribe, :unsubscribe]

  # GET /podcasts/search/:term
  def search
    @podcasts = Podcast.find_or_create_from_api(params[:term])
    render json: @podcasts
  end

  # GET /podcasts/:id
  def show
    if @podcast
      @podcast.update_feed 
      render json: @podcast, include: "genres,episodes"
    else
      render json: { message: "Not found" }, status: :not_found 
    end
  end

  # GET /podcasts
  def index
    @podcasts = @user.podcasts.order(:name)
    render json: @podcasts
  end

  # POST /podcasts/:podcast_id/subscription
  def subscribe
    @subscription = @user.subscriptions.create(podcast: @podcast)
    if @subscription.valid?
      render json: @podcast, status: :created
    else
      render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /podcasts/:podcast_id/subscription
  def unsubscribe
    subscription = Subscription.find_by(user: @user, podcast: @podcast)
    if subscription
      subscription.destroy
      render body: nil, status: :no_content
    else
      render json: { message: "Subscription not found" }, status: :not_found  
    end
  end

  private

  def find_podcast_by_id
    @podcast = Podcast.find_by(id: params[:podcast_id])
  end

  def find_podcast_by_slug
    @podcast = Podcast.find_by(slug: params[:id])
  end

end
