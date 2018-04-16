module API
  class Connection
    def self.host
      'http://34.216.164.119'
    end
    def self.connection
      @@connection ||= Faraday.new url: host do |f|
        # Upstream does not have appropriate CACHE CONTROL, so disabling cache
        # f.use :http_cache, store: Rails.cache, serializer: Marshal, logger: Rails.logger
        f.use Faraday::Response::RaiseError
        f.adapter Faraday.default_adapter
      end
    end
    def self.get resource
      resp = connection.get(resource)
      JSON.parse(resp.body, symbolize_names: true)
    rescue Faraday::ResourceNotFound
      raise API::ResourceNotFound.new("#{resource} is not found")
    end
  end
end
