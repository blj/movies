require 'rails_helper'

describe Person do
  it 'is a subclass of Base' do
    expect(Feature.ancestors).to include(Base)
  end
  context 'uses API' do
    let(:api){class_double('API::Connection').as_stubbed_const}
    context 'to find all' do
      it 'from actor and director resources' do
        actor_ids = [10001, 10003, 10004]
        director_ids = [10001, 10002, 10005]
        expect(api).to receive(:get).with('/actors') { actor_ids }
        expect(api).to receive(:get).with('/directors') { director_ids }
        allow(api).to receive(:get).with('/actors/10001') { {'id': 10001} }
        allow(api).to receive(:get).with('/actors/10001') { {'id': 10001} }
        allow(api).to receive(:get).with('/actors/10002') { {'id': 10002} }
        allow(api).to receive(:get).with('/actors/10003') { {'id': 10003} }
        allow(api).to receive(:get).with('/actors/10004') { {'id': 10004} }
        allow(api).to receive(:get).with('/actors/10005') { {'id': 10005} }

        allow(api).to receive(:get).with('/directors/10001') { {'id': 10001} }
        allow(api).to receive(:get).with('/directors/10001') { {'id': 10001} }
        allow(api).to receive(:get).with('/directors/10002') { {'id': 10002} }
        allow(api).to receive(:get).with('/directors/10003') { {'id': 10003} }
        allow(api).to receive(:get).with('/directors/10004') { {'id': 10004} }
        allow(api).to receive(:get).with('/directors/10005') { {'id': 10005} }

        people = Person.all()
        expect(people.count).to eq(5)
      end
    end
    context 'to build' do
      it 'with both actor and director' do
        expect(api).to receive(:get).with('/actors/1089') { {id: 1089} }
        expect(api).to receive(:get).with('/directors/1089') { {id: 1089} }
        Person.find(1089)
      end
    end
    context 'when neither actor nor director is found' do
      it 'throws record not found error' do
        expect(api).to receive(:get).with('/actors/392'){
          raise API::ResourceNotFound
        }
        expect(api).to receive(:get).with('/directors/392'){
          raise API::ResourceNotFound
        }
        expect {
          Person.find(392)
        }.to raise_error(Error::RecordNotFound)
      end
    end
    context 'using at least one resource' do
      it 'builds the person with actor' do
        expect(api).to receive(:get).with('/actors/3920'){
          {id: 3920}
        }
        expect(api).to receive(:get).with('/directors/3920'){
          raise API::ResourceNotFound
        }
        expect {
          Person.find(3920)
        }.not_to raise_error
      end
    end
    context 'using at least one resource' do
      it 'builds the person with director' do
        expect(api).to receive(:get).with('/actors/3921'){
          raise API::ResourceNotFound
        }
        expect(api).to receive(:get).with('/directors/3921'){
          {id: 3921}
        }
        expect {
          Person.find(3921)
        }.not_to raise_error
      end
    end
    context 'to set its name' do
      it 'from actor' do
        expect(api).to receive(:get).with('/actors/1099') {
          {'id': 1099, 'name': 'Some Name'}
        }
        expect(api).to receive(:get).with('/directors/1099') {
          nil
        }
        person = Person.find(1099)
        expect(person.name).to eq('Some Name')
      end
      it 'from director' do
        expect(api).to receive(:get).with('/actors/2089') {
          nil
        }
        expect(api).to receive(:get).with('/directors/2089') {
          {'id': 2089, 'name': 'Some Other Name'}
        }
        person = Person.find(2089)
        expect(person.name).to eq('Some Other Name')
      end
    end
    context 'to set movies' do
      it 'as a director' do
        expect(api).to receive(:get).with('/actors/3089') {
          nil
        }
        expect(api).to receive(:get).with('/directors/3089') {
          {'id': 3089, 'movies': [2001, 2002, 2003]}
        }
        person = Person.find(3089)
        expect(person.directed_ids).to include(2001, 2003, 2003)
        expect(person.acted_ids).to be_nil
      end
      it 'as a cast member' do
        expect(api).to receive(:get).with('/directors/3029') {
          nil
        }
        expect(api).to receive(:get).with('/actors/3029') {
          {'id': 3029, 'movies': [2001, 2002, 2003]}
        }
        person = Person.find(3029)
        expect(person.directed_ids).to be_nil
        expect(person.acted_ids).to include(2001, 2003, 2003)
      end
      it 'to lazy load the featues when required' do
        feature_class = class_double('Feature').as_stubbed_const
        feature_1 = double('movie 1')
        feature_2 = double('movie 2')
        feature_3 = double('movie 3')
        allow(feature_class).to receive(:find).with(2001) { feature_1 }
        allow(feature_class).to receive(:find).with(2002) { feature_2 }
        allow(feature_class).to receive(:find).with(2003) { feature_3 }
        expect(api).to receive(:get).with('/directors/5099') {
          {'id': 5099, 'movies': [2001, 2002]}
        }
        expect(api).to receive(:get).with('/actors/5099') {
          {'id': 5099, 'movies': [2001, 2003]}
        }
        person = Person.find(5099)
        directed = person.features_directed
        acted = person.features_acted
        expect(directed).to contain_exactly(feature_1, feature_2)
        
        expect(acted).to contain_exactly(feature_1, feature_3)
        
      end
    end
  end
end
