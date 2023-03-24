class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :image_path,
              :cast,
              :reviews

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genres = data[:genres]
    @summary = data[:overview]
    @image_path = data[:poster_path]
    @reviews = create_reviews(data)
    @cast = create_cast(data)
  end

  def create_reviews(review_data)
    review_data[:reviews].map { |review| Review.new(review) } if review_data[:reviews]
  end

  def create_cast(cast_data)
    cast_data[:cast].first(10).map { |cast| CastMember.new(cast) } if cast_data[:cast]
  end
end