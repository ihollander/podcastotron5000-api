class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: :show

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

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end