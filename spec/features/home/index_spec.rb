require 'rails_helper'

RSpec.describe 'home page, index', type: :feature do 

  before :each do
    @adam = User.create!(name: "Adam", email: "adam@aol.com")
    @james = User.create!(name: "James", email: "james@gmail.com")
    @mike = User.create!(name: "Mike", email: "mike@hotmail.com")
    visit "/"
  end

  describe " as a user" do
    describe " when I visit home page" do
      it " I see a button to create a new user" do
        expect(page).to have_button("Create new user")

        click_button "Create new user"

        expect(current_path).to eq(new_user_path)
      end

      it " Has a list of existing Users which links to the users dashboard" do
        within("#existing_users"){
          expect(page).to have_link("adam@aol.com", href: user_path(@adam))
          expect(page).to have_link("james@gmail.com", href: user_path(@james))
          expect(page).to have_link("mike@hotmail.com", href: user_path(@mike))
        }
      end
    end
  end
end