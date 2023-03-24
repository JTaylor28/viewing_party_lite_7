class MovieFacade
  def initialize(params = nil)
    @params = params
  end

  def find_movie(movie_id)
    service = MovieService.new

    json = service.movie_details(movie_id)

    Movie.new(json)
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

    encoded_keyword = CGI.escape(keyword)

    json = service.search_movies(encoded_keyword)

    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def movie
    if @params[:id]
      json_data_array = retrieve_json_data(@params[:id])
    else
      json_data_array = retrieve_json_data(@params[:movie_id])
    end

    combined_json_data = combine_json_data(json_data_array)
    Movie.new(combined_json_data)
  end

  def retrieve_json_data(id)
    service = MovieService.new

    movie_json = service.movie_details(id)
    review_json = service.movie_reviews(id)
    cast_json = service.movie_cast(id)

    [movie_json, review_json, cast_json]
  end

  def combine_json_data(json_array)
    combined_json_data = json_array[0]
    combined_json_data[:reviews] = json_array[1][:results]
    combined_json_data[:total_reviews] = json_array[1][:total_results]
    combined_json_data.merge!(cast: json_array[2][:cast])
  end
end
