$redis = if Rails.env.development? || Rails.env.test?
       Redis.new(:host => '127.0.0.1', :port => 6379)
     else
      Redis.new(:host => SECRETS[:redis_host], :port => 6379)
     end
