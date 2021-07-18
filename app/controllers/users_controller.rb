class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def create
    @user = User.new(user_params)
    if @user.save!
      render json: { user: @user }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      pp @user
      render json: @user
    else
      pp @user
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:email])
     if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: 200
    else
      render json: { error: "Invalid username or password" }, status: 401
    end
  end

  def auto_login
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
