# frozen_string_literal: true

require 'rails_helper'
describe 'Filtered features' do
  context 'filter' do
    context 'by choosing director' do
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
    end
    context 'by choosing actors' do
      it 'can filter feature by any actor chosen' do
        VCR.use_cassette 'features_index_filter-2' do
          visit '/features'
          within_fieldset('any-actors') do
            check('Simon Pegg')
          end
          click_on('Filter')
          expect(page).not_to have_text('Fast & Furious')
          expect(page).to have_selector('tr.feature', count: 5)
        end
      end
      it 'can filter fetures by all actors chosen' do
        VCR.use_cassette 'feature_index_filter-3' do
          visit '/features'
          within_fieldset('all-actors') do
            check('Simon Pegg')
            check('Nick Frost')
            check('Martin Freeman')
          end
          click_on('Filter')
          expect(page).to have_selector('tr.feature', count: 2)
          expect(page).to have_text('Hot Fuzz')
          expect(page).not_to have_text('Shaun of the dead')
        end
      end
    end
  end
end
