class Api::V1::EpisodesController < ApplicationController
  before_action :find_podcast, only: :index

  def index
    @podcast.update_feed # handle checking for updates
    @episodes = @podcast.episodes
    render json: @episodes
  end

  private 

  def find_podcast
    @podcast = Podcast.find_by(id: params[:podcast_id])
  end
  
end
