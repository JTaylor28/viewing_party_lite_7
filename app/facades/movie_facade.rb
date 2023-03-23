class MovieFacade
  def initialize(params)
    @params = params
  end

  def retrieve_movies
    if @params[:q] ==  "top rated"
      top_rated_movies
    else
      search_movies(@params[:q])
    end
  end

  def top_rated_movies
    service = MovieService.new

    json = service.top_rated_movies

    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def search_movies(keyword)
    service = MovieService.new

    encoded_keyword = CGI::escape(keyword)

    json = service.search_movies(encoded_keyword)

    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end