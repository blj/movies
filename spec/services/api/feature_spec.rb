# frozen_string_literal: true

require 'rails_helper'

describe 'Feature' do
  it 'loads returns all movie ids in an array' do
    VCR.use_cassette 'features' do
      feature_ids = API::Feature.ids
      expect(feature_ids).kind_of? Array
      expect(feature_ids[0]).kind_of? Integer
    end
  end
  it 'loads an individual feature from given an id' do
    VCR.use_cassette 'features[0]' do
      feature_ids = API::Feature.ids
      a_feature = API::Feature.get(feature_ids[0])
      expect(a_feature).to include("id", "title", "release", "director", "cast")
    end
  end
end
