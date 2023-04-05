class UsersController < ApplicationController
  before_action :require_login, only: :show

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      flash[:notice] = "#{user.email} created"
      redirect_to user_path(user)
      session[:user_id] = user.id
    else
      flash[:notice] = "Unable to create new user - #{user.errors.full_messages}"
      redirect_to register_path
    end
  end

  def show
    @user = User.find(params[:id])
    @user_viewing_parties = @user.viewing_parties
    @movie_facade = MovieFacade.new
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
      flash[:success] = "Welcome, #{user.email}!"
    else
      flash.now[:error] = "You've entered incorrect credentials, please try again!"
      render :login_form, status: 400
    end
  end

  def logout_user 
    reset_session
    redirect_to root_path
    flash[:notice] = "You've been successfully logged out"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login
    if !session[:user_id]
      flash[:notice] = "Must be logged in or registered to access a dashboard"
      redirect_to root_path
    end
  end
end