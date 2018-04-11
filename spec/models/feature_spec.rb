require 'rails_helper'

describe Feature do
  let(:a_feature) {Feature.new FactoryBot.attributes_for(:feature)}
  it 'supports building an object with attributes' do
    expect(a_feature.title).to eq('Some Movie')
    expect(a_feature.release).to eq(2000)
  end
  context "uses API" do  
    let(:feature_api) {class_double("API::Feature").as_stubbed_const}
    it 'builds a feature from API' do
      expect(feature_api).to receive(:get).with(1) {
        {id: 1, title: 'Some Movie', release: 2000, director_id: 1, actor_ids: [2, 3, 4]}
      }
      a_feature = Feature.find(1)
      expect(a_feature).to have_attributes({
        id: 1, title: 'Some Movie', release: 2000, director_id: 1, actor_ids: [2, 3, 4]
      })
      
    end
    it 'builds all features from API' do
      feature_ids = [1 ,2, 3]
      expect(feature_api).to receive(:ids) {feature_ids}
      feature_ids.each do |id|
        expect(feature_api).to receive(:get).with(id) {
          {id: id}
        }
      end
      features = Feature.all()
      expect(features.count).to eq(3)
    end
  end
end
