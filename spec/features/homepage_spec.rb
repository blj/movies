# frozen_string_literal: true

require 'rails_helper'

describe 'Homepage' do
  it 'has a title' do
    visit '/'
    expect(page).to have_title('Movies')
  end
end
