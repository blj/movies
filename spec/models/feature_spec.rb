require 'rails_helper'

describe Feature do
  let(:a_feature) {Feature.new FactoryBot.attributes_for(:feature)}
  it 'supports building an object with attributes' do
    expect(a_feature.title).to eq('Some Movie')
    expect(a_feature.release).to eq(2000)
  end
  context "uses API" do  
    it 'builds a feature from API' do
      feature_api = class_double("API::Feature").as_stubbed_const
      expect(feature_api).to receive(:get).with(783982) {
        {id: 1, title: 'Some Movie', release: 2000, director_id: 1, actor_ids: [2, 3, 4]}
      }
      a_feature = Feature.find(783982)
      expect(a_feature).to have_attributes({
        id: 1, title: 'Some Movie', release: 2000, director_id: 1, actor_ids: [2, 3, 4]
      })
      
    end
    it 'builds all features from API and caches' do
      feature_api = class_double("API::Feature").as_stubbed_const
      feature_ids = [23232, 332432, 432234]
      expect(feature_api).to receive(:ids).twice {feature_ids}
      feature_ids.each do |id|
        expect(feature_api).to receive(:get).once.with(id) {
          {id: id}
        }
      end
      features = Feature.all()
      features = Feature.all()
      
      expect(features.count).to eq(3)
    end
  end
end
