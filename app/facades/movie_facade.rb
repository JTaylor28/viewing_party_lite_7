class MovieFacade
  def self.top_rated_movies
    service = MovieService.new

    json = service.top_rated_movies

    @movies = json[:results].map do |movie_data|
      create_movie(movie_data)
    end
  end

  def self.search_movies(keyword)
    service = MovieService.new

    encoded_keyword = CGI::escape(keyword)

    json = service.search_movies(encoded_keyword)

    @movies = json[:results].map do |movie_data|
      create_movie(movie_data)
    end
  end

  private
  def self.create_movie(data)
    service = MovieService.new

    movie_id = data[:id]
    
    review_data = service.movie_reviews(movie_id)
    cast_data = service.movie_cast(movie_id)
    movie_data = service.movie_details(movie_id)

    Movie.new(movie_data, review_data, cast_data)
  end
end