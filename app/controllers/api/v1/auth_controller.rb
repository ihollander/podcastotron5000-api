class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create, :google_oauth]
 
  # POST /login
  def create
    @user = User.find_by(username: user_login_params[:username])
    #User#authenticate comes from BCrypt
    if @user && @user.authenticate(user_login_params[:password])
      # encode token comes from ApplicationController
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def google_oauth
    token = params[:token]
    client_id = Rails.application.credentials.google_oauth[:client_id]
    validator = GoogleIDToken::Validator.new
    begin
      payload = validator.check(token, client_id, client_id)
      email = payload['email']
      @user = User.find_or_create_by(username: email)
      if @user.valid?
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
      else
        byebug
        render json: { message: 'failed to create user' }, status: :not_acceptable
      end
    rescue GoogleIDToken::ValidationError => e
      byebug
      report "Cannot validate: #{e}"
    end
  end
 
  private
 
  def user_login_params
    # params { user: {username: 'Chandler Bing', password: 'hi' } }
    params.require(:user).permit(:username, :password)
  end
end
