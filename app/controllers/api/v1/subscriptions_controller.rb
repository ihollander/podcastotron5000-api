class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_user, only: [:create, :index]

  def index
    @subscriptions = @user.subscriptions
    render json: @subscriptions
  end

  def create
    @subscription = @user.subscriptions.create(subscription_params)
    if @subscription.valid?
      render json: @subscription, status: 201
    else
      render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:podcast_id)
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end

  def find_subscription
    @user = User.find_by(id: params[:id])
  end

end
