require 'rails_helper'

describe Feature do
  let(:a_feature) {Feature.new FactoryBot.attributes_for(:feature)}
  it 'supports building an object with attributes' do
    expect(a_feature.title).to eq('Some Movie')
    expect(a_feature.release).to eq(2000)
  end
  context 'uses API' do  
    it 'builds a feature from API' do
      feature_api = class_double("API::Feature").as_stubbed_const
      director_class = class_double('Director').as_stubbed_const
      actor_class = class_double('Actor').as_stubbed_const
      allow(actor_class).to receive(:find)
      allow(director_class).to receive(:find)
      expect(feature_api).to receive(:get).with(783982) {
        {id: 1, title: 'Some Movie', release: 2000, director_id: 1298, actor_ids: [2, 3, 4]}
      }
      a_feature = Feature.find(783982)
      expect(a_feature).to have_attributes({
        id: 1, title: 'Some Movie', release: 2000, director_id: 1298, actor_ids: [2, 3, 4]
      })
      
    end
    it 'builds all features from API and caches' do
      feature_api = class_double("API::Feature").as_stubbed_const
      director_api = class_double('API::Director').as_stubbed_const
      allow(director_api).to receive(:get)
      
      actor_api = class_double('API::Actor').as_stubbed_const
      allow(actor_api).to receive(:get)
      
      feature_ids = [23232, 332432, 432234]
      expect(feature_api).to receive(:ids).twice {feature_ids}
      feature_ids.each do |id|
        expect(feature_api).to receive(:get).once.with(id) {
          {id: id, director_id: 4545}
        }
      end
      features = Feature.all()
      features = Feature.all()
      
      expect(features.count).to eq(3)
    end
  end
  context 'associated objects' do
    it 'loads correct association for director' do
      feature_api = class_double("API::Feature").as_stubbed_const
      director_class = class_double('Director').as_stubbed_const
      director = double
      allow(director_class).to receive(:find).with(2323) {
        director
      }
      allow(feature_api).to receive(:get).with(783982) {
        {id: 783982, director_id: 2323}
      }
      a_feature = Feature.find(783982)
      expect(a_feature.director).to eq(director)
    end
    it 'loads correct association for actors' do
      feature_api = class_double("API::Feature").as_stubbed_const
      actor_class = class_double('Actor').as_stubbed_const
      actor_2001 = double("actor 2001")
      actor_3001 = double("actor 3001")
      actor_4001 = double("actor 4001")
      allow(actor_class).to receive(:find).with([2001, 3001, 4001]) { 
        [actor_2001, actor_3001, actor_4001]
      }

      expect(feature_api).to receive(:get).with(7832) {
        {id: 7832, actor_ids: [2001, 3001, 4001]}
      }
      a_feature = Feature.find(7832)
      expect(a_feature.actors).to include(actor_2001, actor_3001, actor_4001)
    end
  end
end
