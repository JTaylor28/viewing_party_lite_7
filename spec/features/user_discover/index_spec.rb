require "rails_helper"

RSpec.describe "User Discover Index Page" do
  describe 'As a user' do
    describe "When I visit the '/users/:id/discover' path, where :id, is the id of a valid user" do
      before(:each) do
        @user = User.create!(name: "Adam", email: "adam@gmail.com")
        visit user_discover_index_path(@user)
      end

      it "has a button to discover top rated movies which directs me to '/users/:id/discover' page" do
        expect(page).to have_button("Find Top Rated Movies")

        click_button "Find Top Rated Movies"

        expect(current_path).to eq(user_movies_path(@user))
      end

      it "can search by keyword(s) for movie titles" do
        expect(page).to have_field(:q)
        expect(page).to have_button("Find Movies")

        click_button "Find Movies"

        expect(current_path).to eq(user_movies_path(@user))
      end
    end
  end
end