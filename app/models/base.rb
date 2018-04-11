class Base
  include ActiveModel::Model
  class << self
    def find(id)
      object = collection[id]
      return object unless object.blank?
      new(resource.get(id)).tap do |new_object|
        collection[new_object.id] = new_object
      end
    end
    def all
      resource.ids.map do |id|
        find(id)
      end
    end
    def resource
      raise NotImplementedError
    end
    private
    def collection
      @collection||={}
    end
  end
end