require 'rails_helper'
class SomeEntity < Base
end
describe SomeEntity do
  it 'is a subclass of Base' do
    expect(SomeEntity.ancestors).to include(Base)
  end
  it 'supports building an object with attributes' do
    an_entity = SomeEntity.new(id: 200)
    expect(an_entity.id).to eq(200)
  end
  context 'find' do
    it 'can get an object' do
      expect(SomeEntity.find(1)).not_to be_nil
    end
  end
  
end