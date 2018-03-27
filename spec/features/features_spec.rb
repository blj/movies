require 'rails_helper'
describe 'Features' do
  it 'has a title' do
    visit('/features')
    expect(page).to have_title('Features')
  end
  context 'index' do
    it 'shows all features'
    it 'can filter feature by director'
    it 'can filter feature by actor'
  end
  context 'show' do
    it 'shows information about each feature'
  end
end