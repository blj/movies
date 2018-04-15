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
      expect(api).to receive(:get).with('/actors/1')
      expect(api).to receive(:get).with('/directors/1')
      Person.find(1)
    end
    context 'to sets its name' do
      it 'from actor' do
        expect(api).to receive(:get).with('/actors/1') {
          {'id': 1, 'name': 'Some Name'}
        }
        expect(api).to receive(:get).with('/directors/1') {
          nil
        }
        person = Person.find(1)
        expect(person.name).to eq('Some Name')
      end
      it 'from director' do
        expect(api).to receive(:get).with('/actors/2') {
          nil
        }
        expect(api).to receive(:get).with('/directors/2') {
          {'id': 2, 'name': 'Some Other Name'}
        }
        person = Person.find(2)
        expect(person.name).to eq('Some Other Name')
      end
    end
  end
end
