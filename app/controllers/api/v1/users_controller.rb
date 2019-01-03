class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:show]

  # POST 'google/:token', to: 'users#google'
  def google
    # validator = GoogleIDToken::Validator.new
    # begin
    #   payload = validator.check(token, required_audience, optional_client_id)
    #   email = payload['email']
    # rescue GoogleIDToken::ValidationError => e
    #   report "Cannot validate: #{e}"
    # end
  end


  # GET /users/:id 
  def show
    if @user
      render json: @user
    else
      render json: { message: "No user found" }, status: :not_found 
    end
  end

  # POST /users
  def create
    @user = User.find_or_create_by(google_id: params[:google_id])
    if @user.valid?
      render json: @user, status: 201
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end
end