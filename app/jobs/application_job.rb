class ApplicationJob

  include Sidekiq::Worker
  sidekiq_options retry: 0

end
