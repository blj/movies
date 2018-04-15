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
        new(get_from_all_resources(id)).tap do |new_object|
          collection[new_object.id] = new_object
          perform_callbacks(new_object)
        end
      end
    end
    def build_using api
      resources << api
    end
    def resources
      @resources ||= []
    end
    def all
      ids_from_all_resources.map do |id|
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
    def ids_from_all_resources
      resources.collect do |res|
        res.ids
      end.flatten
    end
    def get_from_all_resources(id)
      stuff = resources.collect do |res|
        res.get(id)
      end
      stuff.compact.reduce({}, :merge) unless stuff.blank?
    end
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