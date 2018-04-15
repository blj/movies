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
      API::Director.get(director_ids[0])
    end
  }
  it 'loads id of all directors in an array' do
    expect(director_ids).kind_of? Array
    expect(director_ids[0]).kind_of? Integer
  end
  it 'loads an individual director for an id' do
    expect(a_director).to include(:id, :name, :feature_ids)
  end
  context 'when not available' do
    let(:unavailable_director) {
      VCR.use_cassette 'directors[-2]' do
        API::Director.get(-2)
      end
    }
    it 'returns blank' do
      expect(unavailable_director).to be_nil
    end
  end
end
