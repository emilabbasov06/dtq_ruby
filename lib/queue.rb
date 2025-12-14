require 'json'


class Queue
  def initialize
    @queue = []
  end

  def push(task)
    # Redis insert
    @queue << task
  end

  def pop
    return nil if @queue.empty?
    
    removed_task = @queue.shift
    JSON.parse(removed_task)
  end

  def ack(task_id)
    # Task is already removed from queue because worker was working on it
    true
  end
end
