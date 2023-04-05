require 'rails_helper'

RSpec.describe 'home page, index', type: :feature do 

  
  describe " As a visiter " do

    before :each do
      @adam = User.create!(name: "Adam", email: "adam@aol.com", password: "password123")
      @james = User.create!(name: "James", email: "james@gmail.com", password: "password123")
      @mike = User.create!(name: "Mike", email: "mike@hotmail.com",password: "password123" )
      visit "/"
    end

    describe " when I visit home page" do
      it " I see a button to create a new user" do
        expect(page).to have_button("Create new user")

        click_button "Create new user"

        expect(current_path).to eq(register_path)
      end

      it " I dont see a list of existing Users" do

        expect(page).to_not have_css("#existing_users")
      end

      it " I see a link to login " do
        expect(page).to have_button("Login")

        click_button "Login"

        expect(current_path).to eq(login_path)
      end

      it " I cannot visit the dashboard page " do
        visit user_path(@adam)

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Must be logged in or registered to access a dashboard")
      end
    end
  end

  describe " As a registered user" do

    before :each do
      @james = User.create!(name: "James", email: "james@gmail.com", password: "password123")
      @mike = User.create!(name: "Mike", email: "mike@hotmail.com",password: "password123" )
      @adam = User.create!(name: "Adam", email: "adam@aol.com", password: "password123")
      
      visit login_path
      fill_in :email, with: @adam.email
      fill_in :password, with: @adam.password
      click_button "Log In"
      visit root_path
    end

    describe " When I visit home page " do
      it " I see a list of existing Users" do
      
        within("#existing_users"){
          expect(page).to have_content("adam@aol.com")
          expect(page).to have_content("james@gmail.com")
          expect(page).to have_content("mike@hotmail.com")
        }
      end
    end 
  end
end