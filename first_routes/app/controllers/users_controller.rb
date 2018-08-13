class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def show
    render json: User.find_by(id: params[:id])
  end

  def update
    user = User.find_by(id: params[:id])
    if user
      user.update(user_params)
      render json: user
    else
      render plain: 'User not found', status: 404
    end
  end

  def delete
    user = User.find_by(id: params[:id])
    if user
      user.destroy
      render plain: 'User destroyed'
    else
      render plain: 'User not found', status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end