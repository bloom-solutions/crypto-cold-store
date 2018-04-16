RSpec.configure do |config|
  config.before :each do
    Sidekiq.configure_client do |config|
      config.client_middleware do |chain|
        chain.remove SidekiqUniqueJobs::Client::Middleware
      end
    end
  end
end
