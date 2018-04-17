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
  context 'show' do
    before do
      VCR.use_cassette 'people_show[2]' do
        visit '/people/2'
      end
    end
    it 'has a title' do
      expect(page).to have_title('Simon Pegg')
    end
    it 'has list of movies directed' do
      within('#directed') do
        expect(page).to have_selector('li', count: 1)
        expect(page).to have_link("Simon's Cam")
      end
    end
    it 'has list of movies cast' do
      within('#cast') do
        expect(page).to have_selector('li', count: 5)
        expect(page).to have_link('Hot Fuzz', href: '/features/1')
        expect(page).to have_link("Simon's Cam", href: '/features/2')
        expect(page).to have_link('Shaun of the Dead', href: '/features/3')
        expect(page).to have_link("The World's End", href: '/features/4')
        expect(page).to have_link('Star Trek Beyond', href: '/features/6')
      end
    end
  end
end