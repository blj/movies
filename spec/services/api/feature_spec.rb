# frozen_string_literal: true

require 'rails_helper'

describe 'Feature' do
  let(:feature_ids) {
    VCR.use_cassette('features') do
      API::Feature.ids
    end
  }
  let(:a_feature) {
    VCR.use_cassette 'features[0]' do
      API::Feature.get(feature_ids[0])
    end
  }
  it 'loads id of all movies in an array' do
    expect(feature_ids).kind_of? Array
    expect(feature_ids[0]).kind_of? Integer
  end
  it 'loads an individual feature for an id' do
    expect(a_feature).to include(:id, :title, :release, :director_id, :actor_ids)
  end
  context 'when not available' do
    let(:unavailable_feature) {
      VCR.use_cassette 'features[-2]' do
        API::Feature.get(-2)
      end
    }
    it 'returns blank' do
      expect{
        unavailable_feature
      }.to raise_error(API::ResourceNotFound)
    end
  end
end
