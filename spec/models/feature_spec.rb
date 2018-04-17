require 'rails_helper'

describe Feature do
  it 'is a subclass of Base' do
    expect(Feature.ancestors).to include(Base)
  end
  let (:api) {
    class_double('API::Connection').as_stubbed_const
  }
  context 'when building' do  
    it 'uses API' do
      person_class = class_double('Person').as_stubbed_const
      expect(api).to receive(:get).with('/features/783982') {
        {"id":783982,"title":"Hot Fuzz","release":2000,"director":1011,"cast":[2011,3011,4011]}
      }
      a_feature = Feature.find(783982)
      expect(a_feature).to have_attributes({
        id: 783982, title: 'Hot Fuzz', release: 2000, director_id: 1011, actor_ids: [2011, 3011, 4011]
      })
    end
    it 'can find using either String or Integer for ID' do
      expect(api).to receive(:get).with('/features/9011') { {'id': 9011} }
      expect(api).to receive(:get).with('/features/9012') { {'id': 9012} }
      Feature.find(9011)
      Feature.find('9012')
    end
    context 'a resource is not found' do
      it 'throws record not found error' do
        expect(api).to receive(:get).with('/features/392'){
          raise API::ResourceNotFound
        }
        expect {
          Feature.find(392)
        }.to raise_error(Error::RecordNotFound)
      end
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
      allow(api).to receive(:get).with('/features/7832') {
        {id: 7832, director: 2323}
      }
      a_feature = Feature.find(7832)
      expect(a_feature.director).to eq(director)
    end
    it 'loads correct association for actors' do
      api = class_double('API::Connection').as_stubbed_const
      person_class = class_double('Person').as_stubbed_const
      actor_1 = double("actor 1")
      actor_2 = double("actor 2")
      actor_3 = double("actor 3")
      allow(person_class).to receive(:find).with([801, 802, 803]) {
        [actor_1, actor_2, actor_3]
      }

      expect(api).to receive(:get).with('/features/782') {
        {id: 782, cast: [801, 802, 803]}
      }
      a_feature = Feature.find(782)
      expect(a_feature.actors).to include(actor_1, actor_2, actor_3)
    end
  end
end
