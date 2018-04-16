require 'rails_helper'
class SomeEntityWithoutResources < Base
end
describe SomeEntityWithoutResources do
  context 'a subclass of Base' do
    it 'is a subclass of Base' do
      expect(SomeEntityWithoutResources.ancestors).to include(Base)
    end
    context 'raises resources are not set' do
      it 'when find is called' do
        expect {
          SomeEntityWithoutResources.find(1)
        }.to raise_error(Error::ResourcesNotSet)
      end
      it 'when all is called' do
        expect {
          SomeEntityWithoutResources.all()
        }.to raise_error(Error::ResourcesNotSet)
      end
    end
  end
end
