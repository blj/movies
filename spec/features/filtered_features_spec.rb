# frozen_string_literal: true

require 'rails_helper'
describe 'Filtered features' do
  context 'filter' do
    it 'only lists by a given director' do
      VCR.use_cassette 'features_index_filter-0' do
        visit '/features'
        select('Edgar Wright', from: 'filter_director_id')
        click_on('Filter')
        expect(page).to have_selector('tr.feature', count: 4)
        expect(page).not_to have_selector('td.director', text: 'Simon Pegg')
        expect(page).to have_selector('td.director', text: 'Edgar Wright')
      end
    end
    it 'shows a message when no features are available' do
      VCR.use_cassette 'features_index_filter-1' do
        visit '/features'
        select('Nick Frost', from: 'filter_director_id')
        click_on('Filter')
        expect(page).to have_text('There are no items at this time.')
      end
    end
    it 'can filter feature by actor'
  end
end
