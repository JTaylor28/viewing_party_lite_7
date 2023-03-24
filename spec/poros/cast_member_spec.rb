require "rails_helper"

RSpec.describe CastMember do
  describe "#instance methods" do
    describe "#initialize", :vcr do
      before(:each) do
        @movie = MovieFacade.new({id: 550}).movie
        @cast_member = @movie.cast.first
      end
      
      it 'exists' do
        expect(@cast_member).to be_a(CastMember)
      end

      it 'has readable attributes' do
        expect(@cast_member.name).to eq("Edward Norton")
        expect(@cast_member.character).to eq("The Narrator")
      end
    end
  end
end