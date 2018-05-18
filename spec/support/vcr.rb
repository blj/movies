require 'vcr'

VCR.configure do |config|
  config.default_cassette_options = {
    clean_outdated_http_interactions: true,
    re_record_interval: 5.days.to_i,
    record: :once
  }
  config.cassette_library_dir = Rails.root.join('spec', 'web_fixtures')
  config.hook_into :faraday
  config.ignore_request do |request|
    URI(request.uri).host.match(/mock\.pstmn\.io$/)
  end
end
