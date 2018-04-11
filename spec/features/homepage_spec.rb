# frozen_string_literal: true

require 'rails_helper'

describe 'Homepage' do
  it 'has a title' do
    VCR.use_cassette 'features_index' do
      visit '/'
      expect(page).to have_title('Features')
    end
  end
  it 'has a menu' do
    VCR.use_cassette 'features_index' do
      visit '/'
      expect(page).to have_link('Features', href: '/features')
    end
  end
end
