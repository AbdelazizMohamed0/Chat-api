# frozen_string_literal: true

require 'sneakers'
require 'redis'
require 'json'

$redis = Redis.new

class Processor
  include Sneakers::Worker
  from_queue :logs

  def work(msg)
    err = JSON.parse(msg)
    $redis.incr "processor:#{err['error']}" if err['type'] == 'error'

    ack!
  end
end
