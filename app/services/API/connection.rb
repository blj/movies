class API::Connection
  def self.host
    'http://34.216.164.119'
  end
  def self.connection
    @@connection ||= Faraday.new url: host do |f|
      # Upstream does not have appropriate CACHE CONTROL, so disabling cache
      # f.use :http_cache, store: Rails.cache, serializer: Marshal, logger: Rails.logger
      f.adapter Faraday.default_adapter
    end
  end
  def self.get resource
    resp = connection.get(resource)
    if resp.status == 200
      JSON.parse(resp.body, symbolize_names: true)
    end
  end
end