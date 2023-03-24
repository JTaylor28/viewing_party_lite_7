require "rails_helper"

RSpec.describe Review do
  describe "#instance methods" do
    describe "#initialize", :vcr do
      before(:each) do
        @movie = MovieFacade.new({id: 550}).movie
        @review = @movie.reviews.second
      end
      
      it 'exists' do
        expect(@review).to be_a(Review)
      end

      it 'has readable attributes' do
        expect(@review.author).to eq("Brett Pascoe")
        expect(@review.rating).to eq(9.0)
        expect(@review.content).to eq("In my top 5 of all time favourite movies. Great story line and a movie you can watch over and over again.")
      end
    end
  end
end