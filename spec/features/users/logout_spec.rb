require "rails_helper"

RSpec.describe " User logout" do

  describe "as a logged in user " do
    
    before :each do
      @adam = User.create!(name: "Adam", email: "adam@aol.com", password: "password123")
      
      visit login_path
      
      fill_in :email, with: @adam.email
      fill_in :password, with: @adam.password
      
      click_button "Log In"

      visit root_path
    end

    describe " when I visit home page" do
      it " I no longer see a button to login or create a new user" do

        expect(page).to have_link("Logout")
        expect(page).to have_button("Logout")
        expect(page).to_not have_button("Login")
        expect(page).to_not have_button("Create new user")
      end

      it " when I click the button to logout, I'm taken back to the home page and I see a button to login and create new user" do
        
        click_link "Logout"
        
        expect(current_path).to eq(root_path)
        expect(page).to_not have_link("Logout")
        expect(page).to_not have_button("Logout")
        expect(page).to have_button("Login")
        expect(page).to have_button("Create new user")
      end
    end
  end
end 