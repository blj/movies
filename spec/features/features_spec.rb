# frozen_string_literal: true

require 'rails_helper'
describe 'Features' do  
  context 'index' do
    before do
      VCR.use_cassette 'features_index' do
        visit '/features'
      end
    end
    it 'shows all features' do
      expect(page).to have_title('Features')
      within('#feature_1') do
        expect(page).to have_link('Hot Fuzz', href: '/features/1')
      end
      within('#feature_2') do
        expect(page).to have_link("Simon's Cam", href: '/features/2')
      end
    end
    it 'has release information' do
      within('#feature_1') do
        expect(page).to have_text('2000')
      end
      within('#feature_4') do
        expect(page).to have_text('2013')
      end
    end
    it 'has director information' do
      within('#feature_1') do
        expect(page).to have_text('Edgar Wright')
      end
    end
    it 'has actors listing' do
      within('#feature_1 td.cast') do
        expect(page).to have_link('Simon Pegg', href: '/people/2')
        expect(page).to have_link('Nick Frost', href: '/people/3')
        expect(page).to have_link('Martin Freeman', href: '/people/4')
      end
    end
  end
  context 'filter' do
    it 'only lists by a given director' do
      VCR.use_cassette 'features_index' do
        visit '/features?director=1'
        expect(page).to have_selector('tr.feature', count: 4)
        expect(page).not_to have_selector('td.director', text: 'Simon Pegg')
        expect(page).to have_selector('td.director', text: 'Edgar Wright')
      end
    end
    it 'can filter feature by actor'
  end
  context 'item' do
    it 'shows information about the correct movie' do
      VCR.use_cassette 'features_1_2' do
        visit '/features/1'
        expect(page).to have_title('Hot Fuzz')
        visit '/features/2'
        expect(page).to have_title("Simon's Cam")
      end
    end
    it 'shows information about the correct movie' do
      VCR.use_cassette 'feature_1' do
        visit '/features/1'
        expect(page).to have_selector('h2', text: 'Hot Fuzz')
        within('#release') do 
          expect(page).to have_text('2000')
        end
        within('p#director') do
          expect(page).to have_link('Edgar Wright', href: '/people/1')
        end
        within('#cast') do
          expect(page).to have_selector('li', count: 3)
          expect(page).to have_link('Simon Pegg', href: '/people/2')
          expect(page).to have_link('Nick Frost', href: '/people/3')
          expect(page).to have_link('Martin Freeman', href: '/people/4')
        end
      end
    end
  end
end
