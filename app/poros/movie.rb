class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :genre,
              :summary,
              :cast,
              :reviews

  def initialize(movie_data, review_data, cast_data)
    @title = movie_data[:title]
    @vote_average = movie_data[:vote_average]
    @runtime = movie_data[:runtime]
    @genre = movie_data[:genres]
    @summary = movie_data[:overview]
    @reviews = create_reviews(review_data)
    @cast = create_cast(cast_data)
  end

  def create_reviews(review_data)
    review_data[:results].map { |review| Review.new(review) }
  end

  def create_cast(cast_data)
    cast_data[:cast].map { |cast| CastMember.new(cast) }
  end
end