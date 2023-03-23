class Review
  attr_reader :author,
              :rating,
              :content

  def initialize(data)
    @author = data[:author]
    @rating = data[:author_details][:rating]
    @content = data[:content]
  end
end