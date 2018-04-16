class Base
  include ActiveModel::Model
  attr_accessor :id
  class << self
    def find(arg)
      case arg
      when Array
        arg.map{|item| find_one(item)}
      when Integer
        find_one(arg)
      when String
        find_one(arg.to_i)
      end
    end
    def build_using api, options = {}
      resources << api
      api_options.merge!(options)
    end
    def all
      ids_from_all_resources.map do |id|
        find(id)
      end
    end
    def after_find(method_name)
      @after_find_callbacks ||= []
      @after_find_callbacks << method_name
    end

    private
    def resources
      @resources ||= []
    end
    def api_options
      @api_options ||= {}
    end

    def find_one(id)
      object = collection[id]
      return object unless object.blank?
      new(get_from_all_resources(id)).tap do |new_object|
        collection[new_object.id] = new_object
        perform_callbacks(new_object)
      end
    end
    def ids_from_all_resources
      ensure_resources.collect do |res|
        res.ids
      end.flatten
    end
    def get_from_all_resources(id)
      stuff = ensure_resources.collect do |res|
        begin
          res.get(id)
        rescue API::ResourceNotFound
          nil
        end
      end.compact
      unless stuff.blank?
        stuff.reduce({}, :merge) unless stuff.blank?
      else
        raise Error::RecordNotFound.new("#{id} is not found in any resource #{resources.join(',')}")
      end
    end
    def ensure_resources
      if resources.blank?
        raise Error::ResourcesNotSet.new('a resource must be set with build_using')
      else
        resources
      end
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
