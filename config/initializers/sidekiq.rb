REDIS_URL = {url: ENV['REDISTOGO_URL'] || 'http://127.0.0.1:6379'}

Sidekiq.configure_client do |config|
  config.redis = REDIS_URL
end

Sidekiq.configure_server do |config|
  config.redis = REDIS_URL
end
