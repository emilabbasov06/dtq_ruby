require_relative './lib/producer.rb'
require_relative './lib/queue.rb'
require_relative './lib/worker.rb'

queue = Queue.new
producer = Producer.new(queue)

producer.enqueue('send_email', user_id: 42)
producer.enqueue('send_email', user_id: 93)

worker = Worker.new(queue)
loop do
  worker.work
  sleep 1
end
