class Api::V1::EpisodesController < ApplicationController
  before_action :find_episode, only: :show

  def show
    if @episode
      render json: @episode
    else
      render json: { message: "Not found" }, status: :not_found 
    end
  end

  private 

  def find_episode
    @episode = Episode.find_by(id: params[:id])
  end
  
end
