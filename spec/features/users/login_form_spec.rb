require "rails_helper"

RSpec.describe " User login page " do
  describe "When a user visits the /login path they should see a form to login." do
    before :each do
      visit login_path
      @user = User.create!(name: "Mike", email: "mike@hotmail.com", password: "password123" )
    end

    it " I can input my unique email and password, when I enter my unique email and correct password I'm taken to my dashboard page" do
      
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      
      click_button "Log In"

      expect(current_path).to eq(user_path(@user))
    end

    it "cannot log in with bad credentials, and am taken back to the Log In page where I see a flash message indicating bad credentials" do

      fill_in :email, with: @user.email
      fill_in :password, with: "wrong password"
      
      click_button "Log In"

      expect(current_path).to eq(login_path)
      save_and_open_page
      expect(page).to have_content("You've entered incorrect credentials, please try again!")
    end
  end
end