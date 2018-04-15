require 'rails_helper'

describe Person do
  let(:a_person) {Person.new FactoryBot.attributes_for(:person)}
  it 'supports building an object with attributes' do
    expect(a_person.name).to eq('Some Name')
    expect(a_person.to_s).to eq(a_person.name)
  end
  context 'uses API' do
    let(:api){class_double('API::Connection').as_stubbed_const}
    it 'uses API' do
      expect(api).to receive(:get).with('/actors/1089')
      expect(api).to receive(:get).with('/directors/1089')
      Person.find(1089)
    end
    context 'to sets its name' do
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
  end
end
