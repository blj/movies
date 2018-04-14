# frozen_string_literal: true

require 'rails_helper'
describe 'People' do
  context 'index' do
    before do
      VCR.use_cassette 'people_index' do
        visit '/people'
      end
    end
    it 'has a title' do
      expect(page).to have_title('Actors and Directors')
    end
    it 'lists actor names' do
      within('#people') do
        expect(page).to have_text('Simon Pegg')
      end
    end
  end
end