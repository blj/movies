# frozen_string_literal: true

module API
  # Connection provides single point access to external service
  class Connection
    def self.host
      'http://34.216.164.119'
      # 'https://f0cfe4bf-6efe-44e3-be6f-057a7baafb75.mock.pstmn.io'
    end
    class << self
      def connection
        @connection ||= Faraday.new url: host do |f|
          # Upstream does not have appropriate CACHE CONTROL, so disabling cache
          # f.use :http_cache, store: Rails.cache,
          # serializer: Marshal, logger: Rails.logger
          f.adapter Faraday.default_adapter
        end
      end

      def get(resource)
        resp = connection.get(resource)
        if resp.status == 404
          raise API::ResourceNotFound, "#{resource} is not found"
        end
        JSON.parse(resp.body, symbolize_names: true)
      end
    end
  end
end
