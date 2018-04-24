# frozen_string_literal: true

# Base class that provides common functionality for models
class Base
  include ActiveModel::Model
  attr_accessor :id
  class << self
    def find(arg)
      case arg
      when Array
        arg.map { |item| find_one(item) }
      when Integer
        find_one(arg)
      when String
        find_one(arg.to_i)
      end
    end

    def build_using(api, attrs_processor = nil)
      resources << [api, attrs_processor]
    end

    def all(_options = {})
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
      ensure_resources.collect do |res, _processor|
        res.ids
      end.flatten.uniq
    end

    def get_from_all_resources(id)
      stuff = ensure_resources.collect do |res, processor|
        process_response_from_api processor, get_from_a_resource(id, res)
      end.compact

      if stuff.blank?
        raise Error::RecordNotFound,
              "#{id} is not found in any resource #{resources.join(',')}"
      end
      stuff.reduce({}, :merge) unless stuff.blank?
    end

    def get_from_a_resource(id, res)
      res.get(id)
    rescue API::ResourceNotFound
      nil
    end

    def process_response_from_api(processor, response)
      return response if processor.blank? || response.blank?
      processor.call response
    end

    def ensure_resources
      if resources.blank?
        raise Error::ResourcesNotSet, 'a resource must be set with build_using'
      end
      resources
    end

    def collection
      @collection ||= {}
    end
  end

  def [](key)
    send key
  end
end
