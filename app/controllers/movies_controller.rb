class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    if params[:q] == "top rated"
      @movies = MovieFacade.top_rated_movies
    else
      @movies = MovieFacade.search_movies(params[:q])
    end
  end

  def show
    
  end
end