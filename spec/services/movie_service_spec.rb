require 'rails_helper'

RSpec.describe MovieService do
  describe '#instance methods', :vcr do
    before(:each) do
      @movie_service = MovieService.new
    end

    describe '#top_rated_movies' do
      it 'retrieves top rated movies data' do
        expect(@movie_service.top_rated_movies).to be_a(Hash)
        expect(@movie_service.top_rated_movies[:results]).to be_a(Array)
        expect(@movie_service.top_rated_movies[:results].first[:title]).to be_a(String)
        expect(@movie_service.top_rated_movies[:results].first[:title]).to eq("The Godfather")
      end
    end

    describe '#movie_cast' do
      it 'retrieves movies cast' do
        expect(@movie_service.movie_cast(550)).to be_a(Hash)
        expect(@movie_service.movie_cast(550)[:cast]).to be_a(Array)
        expect(@movie_service.movie_cast(550)[:cast].first[:name]).to be_a(String)        
        expect(@movie_service.movie_cast(550)[:cast].first[:name]).to eq("Edward Norton")        
      end
    end
    
    describe '#movie_reviews' do
      it 'retrieves movies reviews' do
        expect(@movie_service.movie_reviews(550)).to be_a(Hash)
        expect(@movie_service.movie_reviews(550)[:results]).to be_a(Array)
        expect(@movie_service.movie_reviews(550)[:results].first[:author]).to be_a(String)        
        expect(@movie_service.movie_reviews(550)[:results].first[:author]).to eq("Goddard")
      end
    end

    describe '#movie_details' do
      it 'retrieves movies details' do
        expect(@movie_service.movie_details(550)).to be_a(Hash)
        expect(@movie_service.movie_details(550)[:original_title]).to be_a(String)        
        expect(@movie_service.movie_details(550)[:original_title]).to eq("Fight Club")
      end
    end

    describe '#search_movies' do
      it 'retrieves movies based on search params' do
        expect(@movie_service.search_movies("Fight+Club")).to be_a(Hash)
        expect(@movie_service.search_movies("Fight+Club")[:results]).to be_a(Array)
        expect(@movie_service.search_movies("Fight+Club")[:results].first[:title]).to be_a(String)
        expect(@movie_service.search_movies("Fight+Club")[:results].first[:title]).to eq("Fight Club")
      end
    end

    describe '#get_url' do
      it 'returns json hash based on endpoint' do
        expect(@movie_service.get_url("/3/movie/550")).to be_a(Hash)
        expect(@movie_service.get_url("/3/movie/550")[:original_title]).to be_a(String)        
        expect(@movie_service.get_url("/3/movie/550")[:original_title]).to eq("Fight Club")
      end
    end

    describe '#conn' do
      it 'creates faraday object with api connection' do
        expect(@movie_service.conn).to be_a(Faraday::Connection)
        expect(@movie_service.conn.url_prefix).to be_a(URI::HTTPS)
        expect(@movie_service.conn.url_prefix.hostname).to eq("api.themoviedb.org")
      end
    end
  end
end