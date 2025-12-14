# Worker class will complete tasks which were sent to it
class Worker
  def initialize(queue)
    @queue = queue
  end

  def work
    task = @queue.pop
    return unless task

    puts "[INFO]: Working on #Task::#{task['id']}"
    self.execute(task)

    @queue.ack(task['id'])
  end

  private def execute(task)
    case task['task_name']
    when 'send_email'
      self.send_email(task['args'])
    else
      puts 'Unknown task'
    end
  end

  private def send_email(args)
    puts "Sending email to user #{args['user_id']}"
  end
end
