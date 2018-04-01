class ApplicationJob

  include Sidekiq::Worker
  sidekiq_options retry: false

end
