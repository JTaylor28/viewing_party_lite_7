class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @movie_facade = MovieFacade.new(params)
  end

  def show
    
  end
end