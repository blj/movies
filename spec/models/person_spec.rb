require 'rails_helper'

describe Person do
  it 'is a subclass of Base' do
    expect(Feature.ancestors).to include(Base)
  end
  context 'uses API' do
    let(:api){class_double('API::Connection').as_stubbed_const}
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
