require 'rails_helper'
describe 'Common Actors in movies' do
  it 'allows selecting movies from a list' do
    VCR.use_cassette 'common-actors-filter-0' do
      visit '/features'
      within_fieldset('features') do
        check('feature_ids[]', option: '1')
        check('feature_ids[]', option: '6')
      end
      click_on('Show Common Actors')
      expect(page).to have_title('Common Actors in Hot Fuzz and Star Trek Beyond')
      expect(page).to have_selector('tr.person', count: 1)
      expect(page).to have_selector('td.name', text: 'Simon Pegg')
      expect(page).not_to have_text('Nick Frost')
    end
  end
end