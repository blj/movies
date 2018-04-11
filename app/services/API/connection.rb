class API::Connection
  def self.host
    'http://34.216.164.119'
  end
  def self.connection
    @@connection ||= Faraday.new url: host do |f|
      # Upstream does not have appropriate CACHE CONTROL, so disabling cache
      # f.use :http_cache, store: Rails.cache, serializer: Marshal, logger: Rails.logger
      f.response :json
      f.adapter Faraday.default_adapter
    end
  end
  def self.get resource
    connection.get(resource).body
  end
end