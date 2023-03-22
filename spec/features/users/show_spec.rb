require "rails_helper"

RSpec.describe "User dashboard(show) page", type: :feature do
  before :each do
    @adam = User.create!(name: "Adam", email: "adam@aol.com")
    @james = User.create!(name: "James", email: "james@gmail.com")
    @mike = User.create!(name: "Mike", email: "mike@hotmail.com")
    visit user_path(@adam.id)
  end

  describe " when I visit the user dashboard" do
    
    it " I see users name at the top of the page " do
      expect(page).to have_content "Adam's Dashboard"
    end

    it " I see a button to Discover Movies" do
      expect(page).to have_button "Discover Movies"

      click_button "Discover Movies"

      expect(current_path).to eq(discover_user_path(@adam.id))
    end

    # it " I see a section that lists viewing parties" do
    #   expect(page).to has_section?("view_parties_container")
    # end
  end
end