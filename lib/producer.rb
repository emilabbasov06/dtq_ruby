require 'securerandom'
require 'time'
require 'json'


# Producer is the class which will create and enqueue jobs or tasks
class Producer
  def initialize(queue)
    @queue = queue
  end

  def enqueue(task_name, args = {})
    task = {
      id: SecureRandom.uuid,
      task_name: task_name,
      args: args,
      state: 'PENDING',
      created_at: Time.now.utc.iso8601
    }

    @queue.push(task.to_json)
    task[:id]
  end
end
