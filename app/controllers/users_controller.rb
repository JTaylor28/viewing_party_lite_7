class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      flash[:notice] = "#{user.email} created"
      redirect_to user_path(user)
    else
      flash[:notice] = "Unable to create new user - #{user.errors.full_messages}"
      redirect_to register_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def discover  
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end