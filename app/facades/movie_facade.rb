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

  def movie
    service = MovieService.new
    movie_json = service.movie_details(@params[:id])
    review_json = service.movie_reviews(@params[:id])
    cast_json = service.movie_cast(@params[:id])

    combined_json_data = combine_json_data([movie_json, review_json, cast_json])
    x = Movie.new(combine_json_data(combined_json_data))
  end
  
  def combine_json_data(json_array)
    combined_json_data = {}
    # combined_json_data[:movie_details] = json_array[0]
    # combined_json_data[:credits][:cast] = json_array[1]
    # combined_json_data[:reviews][:] = json_array[2]
    require 'pry'; binding.pry
    combined_json_data.merge(json_array[0])
    require 'pry'; binding.pry
    combined_json_data.merge(reviews: json_array[1][:results], total_reviews: json_array[1][:total_results])
    combined_json_data.merge(cast: json_array[2][:cast])
    combined_json_data
    require 'pry'; binding.pry
  end
end