# frozen_string_literal: true

require 'sidekiq/web'

redis_config = { size: 1, db: 0, host: ENV['REDIS_HOST'] }

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

run Rack::URLMap.new('/sidekiq' => Sidekiq::Web)
