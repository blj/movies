class Base
  include ActiveModel::Model
  class << self
    def find(id)
      object = collection[id]
      return object unless object.blank?
      new(resource.get(id)).tap do |new_object|
        collection[new_object.id] = new_object
        perform_callbacks(new_object)
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
    def after_find(method_symbol)
      @after_find_callbacks ||= []
      @after_find_callbacks << method_symbol
    end
    private
    def perform_callbacks(object)
      unless @after_find_callbacks.blank?
        @after_find_callbacks.each do |method_symbol|
          object.send method_symbol
        end
      end
    end
    def collection
      @collection||={}
    end
  end
end