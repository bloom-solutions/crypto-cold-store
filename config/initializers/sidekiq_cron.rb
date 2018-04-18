Sidekiq.configure_server do |config|
  schedule_file = "config/sidekiq_cron.yml"

  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end

  Sidekiq.options[:poll_interval] = 5
end
