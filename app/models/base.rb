class Base
  class << self
    def find(arg)
      case arg
      when Array
        arg.map{|item| find(item)}
      else
        id = arg
        object = collection[id]
        return object unless object.blank?
        new(resource.get(id)).tap do |new_object|
          collection[new_object.id] = new_object
          perform_callbacks(new_object)
        end
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
    def after_find(method_name)
      @after_find_callbacks ||= []
      @after_find_callbacks << method_name
    end
    private
    def perform_callbacks(object)
      unless @after_find_callbacks.blank?
        @after_find_callbacks.each do |method|
          object.send method.to_sym
        end
      end
    end
    def collection
      @collection||={}
    end
  end
end