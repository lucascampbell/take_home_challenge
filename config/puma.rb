if defined?(Puma)
  on_worker_boot do
    $redis.client.disconnect
    uri = URI.parse(ENV["REDISTOGO_URL"])
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true, :size => Integer(ENV['MAX_REDIS_CONNECTION']))
    Rails.logger.info "Reconnecting to redis"
  end
end