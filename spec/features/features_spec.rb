# frozen_string_literal: true

require 'rails_helper'
describe 'Features' do
  context 'index' do
    it 'shows all features' do
      VCR.use_cassette :features do
        visit('/features')
        expect(page).to have_title('Features')
        expect(page).to have_link('Avengers', href: '/features/1')
        expect(page).to have_link('Sherlock Holmes', href: '/features/2')
        expect(page).to have_link('Much Ado About Nothing', href: '/features/3')
      end
    end
    it 'can filter feature by director'
    it 'can filter feature by actor'
  end
  context 'item' do
    it 'shows information about that movie'
  end
end
