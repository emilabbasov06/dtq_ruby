require 'json'
require 'time'


class TaskQueue
  @@QUEUE_KEY = 'dtq:tasks:queue'
  @@IN_PROGRESS_KEY = 'dtq:tasks:in_progress'

  def initialize(redis)
    @redis = redis
  end

  def push(task)
    @redis.rpush(@@QUEUE_KEY, task)
  end

  def pop
    removed_task = @redis.lpop(@@QUEUE_KEY)
    return unless removed_task

    in_progress_task = JSON.parse(removed_task)

    @redis.hset(
      @@IN_PROGRESS_KEY,
      in_progress_task['id'],
      {
        task: in_progress_task,
        started_time: Time.now.to_i
      }.to_json
    )

    in_progress_task
  end

  def ack(task_id)
    @redis.hdel(@@IN_PROGRESS_KEY, task_id)
    puts "[SUCCESS]: Task::#{task_id} is done"
  end
end
