class JobsQueue
  def initialize
    @queue = []
  end

  def enqueue(job_name, args: {})
    whole_job = {
      name: job_name,
      args: args
    }

    @queue << whole_job
  end
end
