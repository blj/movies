require 'rails_helper'

describe Feature do
  let(:a_feature) {Feature.new FactoryBot.attributes_for(:feature)}
  it 'supports building an object with attributes' do
    expect(a_feature.title).to eq('Some Movie')
    expect(a_feature.release).to eq(2000)
  end
  let (:api) {
    class_double('API::Connection').as_stubbed_const
  }
  context 'when building' do  
    it 'uses API' do
      expect(api).to receive(:get).with('/features/783982') {
        {"id":1,"title":"Hot Fuzz","release":2000,"director":1011,"cast":[2011,3011,4011]}
      }
      expect(api).to receive(:get).with('/actors/1011')
      expect(api).to receive(:get).with('/directors/1011')
      expect(api).to receive(:get).with('/actors/2011')
      expect(api).to receive(:get).with('/directors/2011')
      expect(api).to receive(:get).with('/actors/3011')
      expect(api).to receive(:get).with('/directors/3011')
      expect(api).to receive(:get).with('/actors/4011')
      expect(api).to receive(:get).with('/directors/4011')
      a_feature = Feature.find(783982)
      expect(a_feature).to have_attributes({
        id: 1, title: 'Hot Fuzz', release: 2000, director_id: 1011, actor_ids: [2011, 3011, 4011]
      })
    end
    it 'first time uses API and then caches' do
      feature_ids = [23232, 332432, 432234]
      allow(api).to receive(:get).with("/features").twice {feature_ids}
      feature_ids.each do |id|
        expect(api).to receive(:get).with("/features/#{id}").once {
          {id: id, director_id: 4545}
        }
      end
      features = Feature.all()
      features = Feature.all()
      expect(features.count).to eq(3)
    end
  end
  context 'for associated objects' do
    it 'loads correct association for director' do
      person_class = class_double('Person').as_stubbed_const
      director = double
      allow(person_class).to receive(:find).with(2323) {
        director
      }
      allow(api).to receive(:get).with('/features/783982') {
        {id: 783982, director: 2323}
      }
      a_feature = Feature.find(783982)
      expect(a_feature.director).to eq(director)
    end
    it 'loads correct association for actors' do
      api = class_double('API::Connection').as_stubbed_const
      person_class = class_double('Person').as_stubbed_const
      actor_2001 = double("actor 2001")
      actor_3001 = double("actor 3001")
      actor_4001 = double("actor 4001")
      allow(person_class).to receive(:find).with([2001, 3001, 4001]) { 
        [actor_2001, actor_3001, actor_4001]
      }

      expect(api).to receive(:get).with('/features/7832') {
        {id: 7832, cast: [2001, 3001, 4001]}
      }
      a_feature = Feature.find(7832)
      expect(a_feature.actors).to include(actor_2001, actor_3001, actor_4001)
    end
  end
end
