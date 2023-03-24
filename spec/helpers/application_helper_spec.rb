require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'convert_to_hours_and_minutes' do
    it 'converts minutes into a string of hours and minutes' do
      expect(convert_to_hours_and_minutes(200)).to eq("3hr 20min")
    end
  end
end