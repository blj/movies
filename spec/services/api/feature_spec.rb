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
      a_feature = API::Feature.get(feature_ids[0])
    end
  }
  it 'loads id of all movies in an array' do
    expect(feature_ids).kind_of? Array
    expect(feature_ids[0]).kind_of? Integer
  end
  it 'loads an individual feature for an id' do
    expect(a_feature).to include("id", "title", "release", "director_id", "actor_ids")
  end
end
