require 'rails_helper'

describe Person do
  it 'is a subclass of Base' do
    expect(Feature.ancestors).to include(Base)
  end
  context 'uses API' do
    let(:api){class_double('API::Connection').as_stubbed_const}
    it 'uses API' do
      expect(api).to receive(:get).with('/actors/1089')
      expect(api).to receive(:get).with('/directors/1089')
      Person.find(1089)
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
          {'id': 2089, 'movies': [2001, 2002, 2003]}
        }
        person = Person.find(3089)
        expect(person.directed_ids).not_to be_nil
        expect(person.directed_ids).to include(2001, 2003, 2003)
      end
      it 'as a cast member' do
        
      end
    end
  end
end
