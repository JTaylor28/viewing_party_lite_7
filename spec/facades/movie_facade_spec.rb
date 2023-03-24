require 'rails_helper'

RSpec.describe MovieFacade do
  describe '#instance methods', :vcr do
    before(:each) do
      @movie_facade = MovieFacade.new(id: 550)
    end

    describe '#initialize' do
      it 'exists' do
        expect(@movie_facade).to be_a(MovieFacade)
      end
    end

    describe '#find_movies' do
      it 'returns a movie object for specific movie id' do
        expected_movie = @movie_facade.find_movie(550)

        expect(expected_movie).to be_a(Movie)
        expect(expected_movie.id).to eq(550)
      end
    end

    context '#retrieve_movies' do
      describe '#top_rated_movies' do
        it 'returns the top 20 rated movies if params[:q] is "top rated"' do
          @top_rated_movie_facade = MovieFacade.new(q: "top rated")

          expect(@top_rated_movie_facade.retrieve_movies).to be_a(Array)
          expect(@top_rated_movie_facade.retrieve_movies.first).to be_a(Movie)
          expect(@top_rated_movie_facade.retrieve_movies.count).to eq(20)
        end
      end

      describe '#search_movies' do
        it 'returns the first 20 search results for movies if params[:q] is not "top rated"' do
          @search_movie_facade = MovieFacade.new(q: "Fight Club")

          expect(@search_movie_facade.retrieve_movies).to be_a(Array)
          expect(@search_movie_facade.retrieve_movies.first).to be_a(Movie)        
          expect(@search_movie_facade.retrieve_movies.count).to eq(20)
          expect(@search_movie_facade.retrieve_movies.first.title).to eq("Fight Club")
        end
      end
    end

    describe '#movie' do
      it 'returns the movie object for given params[:id]' do
        expect(@movie_facade.movie).to be_a(Movie)        
        expect(@movie_facade.movie.id).to eq(550)
        expect(@movie_facade.movie.title).to eq("Fight Club")
      end

      it 'returns the movie object for given params[:movie_id]' do
        movie_id_movie_facade = MovieFacade.new(movie_id: 550)

        expect(movie_id_movie_facade.movie).to be_a(Movie)        
        expect(movie_id_movie_facade.movie.id).to eq(550)
        expect(movie_id_movie_facade.movie.title).to eq("Fight Club")
      end
    end

    describe '#combine_json_data' do
      it 'combines multiple sets of parsed json data' do
        service = MovieService.new

        movie_json = service.movie_details(550)
        review_json = service.movie_reviews(550)
        cast_json = service.movie_cast(550)

        combined_json_data = @movie_facade.combine_json_data([movie_json, review_json, cast_json])

        expect(combined_json_data).to be_a(Hash)
        expect(combined_json_data[:title]).to eq("Fight Club")
        expect(combined_json_data[:cast]).to_not eq(nil)
        expect(combined_json_data[:reviews]).to_not eq(nil)
      end
    end
  end
end