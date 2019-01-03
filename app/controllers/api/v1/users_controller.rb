class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:show, :remove_subscription]

  def google_signin
    @user = User.find_or_create_by(google_id: params[:google_id])
    if @user
      render json: @user
    else
      render json: { message: "No user found" }, status: :not_found 
    end
  end

  def show
    if @user
      render json: @user
    else
      render json: { message: "No user found" }, status: :not_found 
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: @user, status: 201
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def remove_subscription
    subscription = @user.subscriptions.find_by(podcast_id: params[:podcast_id])
    if subscription
      subscription.destroy
      render body: nil, status: :no_content
    else
      render json: { message: "Subscription not found" }, status: :not_found  
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end