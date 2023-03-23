class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genre,
              :summary
              # :cast,
              # :reviews

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genre = data[:genres]
    @summary = data[:overview]
    # @reviews = create_reviews(data)
    # @cast = create_cast(data)
  end

  def create_reviews(review_data)
    review_data[:results].map { |review| Review.new(review) } if review_data[:cast]
  end

  def create_cast(cast_data)
    cast_data[:cast].first(10).map { |cast| CastMember.new(cast) } if review_data
  end
end