class UsersController < ApplicationController
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    user_id = params[:id]
    user = User.find(user_id)
    if current_user && current_user.id == user_id
      render json: user
    else
      render json: current_user, status: :unauthorized
    end
  end
end
