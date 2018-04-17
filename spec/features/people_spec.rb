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
    it 'lists people with acted and directed names' do
      within('#person_2') do
        expect(page).to have_selector('.name', text: 'Simon Pegg')
        expect(page).to have_selector('.directed', text: "Simon's Cam")
        expect(page).to have_selector('.acted', text: "Hot Fuzz, Simon's Cam, Shaun of the Dead, The World's End, and Star Trek Beyond")
      end
    end
    it 'lists people with acted and directed names' do
      within('#person_3') do
        expect(page).to have_selector('.name', text: 'Nick Frost')
        expect(page).to have_selector('.directed', text: '')
        expect(page).to have_selector('.acted', text: "Hot Fuzz, Simon's Cam, Shaun of the Dead, and The World's End")
      end
    end
  end
end