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
    def to_param
      id
    end
    def build_using api, attrs_processor = nil
      resources << [api, attrs_processor]
    end
    def all
      ids_from_all_resources.map do |id|
        find(id)
      end
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
      end
    end
    def ids_from_all_resources
      ensure_resources.collect do |res, processor|
        res.ids
      end.flatten.uniq
    end
    def get_from_all_resources(id)
      stuff = ensure_resources.collect do |res, processor|
        begin
          if processor.blank?
            res.get(id)
          else
            stuff = res.get(id)
            processor.call stuff
          end
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
    def collection
      @collection||={}
    end
  end
end
