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
  end
  context 'filter' do
    it 'can filter feature by director'
    it 'can filter feature by actor'
  end
  context 'item' do
    let :feature_1_page do
      VCR.use_cassette 'features_1' do
        visit '/features/1'
        page
      end
    end
    let :feature_2_page do
      VCR.use_cassette 'features_2' do
        visit '/features/2'
        page
      end
    end
    it 'shows information about the correct movie' do
      expect(feature_1_page).to have_title('Hot Fuzz')
      expect(feature_2_page).to have_title("Simon's Cam")
    end
  end
end
