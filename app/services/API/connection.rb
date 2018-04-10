class API::Connection
  def self.host
    'http://34.216.164.119'
  end
  def self.connection
    @@connection ||= Faraday.new url: host do |f|
      f.response :json
      f.adapter Faraday.default_adapter
    end
  end
  def self.get resource
    connection.get(resource).body
  end
end