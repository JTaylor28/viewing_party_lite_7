class MovieService
  def top_rated_movies
    get_url("/3/movie/top_rated?page=1")
  end

  def movie_cast(movie_id)
    get_url("/3/movie/#{movie_id}/credits?page=1")
  end
  
  def movie_reviews(movie_id)
    get_url("/3/movie/#{movie_id}/reviews")
  end

  def movie_details(movie_id)
    get_url("/3/movie/#{movie_id}")
  end

  def search_movies(keyword)
    get_url("/3/search/movie?language=en-US&query=#{keyword}&page=1")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org") do |f|
      f.headers["Authorization"] = ENV["TMDB_API_KEY"]
    end
  end
end