class Api::V1::PodcastsController < ApplicationController

  def search
    @podcasts = Podcast.find_or_create_from_api(params[:term])
    render json: @podcasts
  end
  
end
