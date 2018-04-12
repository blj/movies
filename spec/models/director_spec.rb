require 'rails_helper'

describe Director do
  context "uses API" do  
    it 'builds a director from API' do
      director_api = class_double("API::Director").as_stubbed_const
      expect(director_api).to receive(:get).with(1982) {
        {id: 1982, name: 'Some Person', feature_ids: [1, 2, 3]}
      }
      a_director = Director.find(1982)
      expect(a_director.id).to eq(1982)
      expect(a_director.name).to eq('Some Person')
      expect(a_director.feature_ids).to include(1, 2, 3)
    end
    it 'builds all directors from API and caches' do
      director_api = class_double("API::Director").as_stubbed_const
      director_ids = [332, 3324, 32323]
      expect(director_api).to receive(:ids).twice {director_ids}
      director_ids.each do |id|
        expect(director_api).to receive(:get).once.with(id) {
          {id: id}
        }
      end
      directors = Director.all()
      directors = Director.all()
      
      expect(directors.count).to eq(3)
    end
  end
end
