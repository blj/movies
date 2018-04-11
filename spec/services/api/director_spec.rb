# frozen_string_literal: true

require 'rails_helper'

describe 'Director' do
  let(:director_ids) {
    VCR.use_cassette('directors') do
      API::Director.ids
    end
  }
  let(:a_director) {
    VCR.use_cassette 'directors[0]' do
      a_director = API::Director.get(director_ids[0])
    end
  }
  it 'loads id of all movies in an array' do
    expect(director_ids).kind_of? Array
    expect(director_ids[0]).kind_of? Integer
  end
  it 'loads an individual director for an id' do
    expect(a_director).to include("id", "name", "movies")
  end
end
