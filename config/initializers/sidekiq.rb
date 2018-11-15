class CustomSidekiqJobLogger < Sidekiq::JobLogger
  def call(item, queue, &block)
    logger.tagged(*context_tags(item)) do
      super(item, queue, &block)
    end
  end

  private

  def context_tags(item)
    [
      item['class'],
      item['jid'],
    ]
  end

  def logger
    Rails.logger
  end
end

Sidekiq.configure_server do |config|
  config.options[:job_logger] = CustomSidekiqJobLogger
end

SidekiqAlive.start
