if Rails.env.test?
  MessageBus.configure(backend: :memory)
else
  MessageBus.configure({
    backend: :postgres,
    backend_options: ENV["MESSAGE_BUS_PG_CONNECTION_STRING"],
    clear_every: 1_000,
  })

  # 10 days in seconds
  MessageBus.reliable_pub_sub.max_backlog_age =
    ENV.fetch("MESSAGE_BUS_MAX_BACKLOG_AGE") { 10 * 24 * 60 * 60 }.to_i

  MessageBus.reliable_pub_sub.max_backlog_size =
    ENV.fetch("MESSAGE_BUS_MAX_BACKLOG_SIZE") { 10_000_000 }.to_i

  MessageBus.reliable_pub_sub.max_global_backlog_size =
    ENV.fetch("MESSAGE_BUS_MAX_GLOBAL_BACKLOG_SIZE") { 10_000_000 }.to_i
end
