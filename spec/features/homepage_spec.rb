# frozen_string_literal: true

require 'rails_helper'

describe 'Homepage' do
  it 'has a title' do
    visit '/'
    expect(page).to have_title('Features')
  end
  it 'has a menu' do
    visit '/'
    expect(page).to have_link('Features', href: '/features')
  end
end
