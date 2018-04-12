require 'rails_helper'

describe Actor do
  context "uses API" do  
    it 'builds an actor from API' do
      actor_api = class_double("API::Actor").as_stubbed_const
      expect(actor_api).to receive(:get).with(1984) {
        {id: 1984, name: 'Some Person', feature_ids: [1, 2, 3]}
      }
      a_actor = Actor.find(1984)
      expect(a_actor.id).to eq(1984)
      expect(a_actor.name).to eq('Some Person')
      expect(a_actor.feature_ids).to include(1, 2, 3)
    end
    it 'builds all actors from API and caches' do
      actor_api = class_double("API::Actor").as_stubbed_const
      actor_ids = [3322, 34324, 3223]
      expect(actor_api).to receive(:ids).twice {actor_ids}
      actor_ids.each do |id|
        expect(actor_api).to receive(:get).once.with(id) {
          {id: id}
        }
      end
      actors = Actor.all()
      actors = Actor.all()
      
      expect(actors.count).to eq(3)
    end
  end
end
