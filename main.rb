require 'redis'
require_relative './lib/producer.rb'
require_relative './lib/queue.rb'
require_relative './lib/worker.rb'


redis = Redis.new(
  host: 'localhost',
  port: 6379,
  db: 11
)

queue = TaskQueue.new(redis)
producer = Producer.new(queue)
worker = Worker.new(queue)

producer.enqueue('send_email', user_id: 234432)
producer.enqueue('send_email', user_id: 234432)
producer.enqueue('send_email', user_id: 234432)
producer.enqueue('send_email', user_id: 234432)
producer.enqueue('send_email', user_id: 234432)
producer.enqueue('send_email', user_id: 234432)
loop do
  worker.work
  sleep 5
end
