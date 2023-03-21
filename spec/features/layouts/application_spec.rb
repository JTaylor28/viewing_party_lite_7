require 'rails_helper'

RSpec.describe 'application, pages', type: :feature do
  describe "every page" do
    it "has a home link" do 
      visit root_path
      expect(page).to have_link("Home", href: root_path)
    end 
  end
end 