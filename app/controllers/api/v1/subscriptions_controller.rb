class Api::V1::SubscriptionsController < ApplicationController
  before_action :current_user

  def index
    @subscriptions = @user.subscriptions
    render json: @subscriptions
  end

  def create
    @subscription = @user.subscriptions.create(subscription_params)
    if @subscription.valid?
      @podcast = Podcast.find_by(id: params[:podcast_id])
      render json: @podcast, status: :created, serializer: PodcastSearchSerializer
    else
      render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @subscription = Subscription.find_by(id: params[:id])
    @subscription.destroy
    render body: nil, status: :no_content
  end

  private

  def subscription_params
    params.require(:subscription).permit(:podcast_id)
  end

  def current_user
    @user = User.find_by(id: params[:user_id])
  end

end
