if Rails.env.test?
  MessageBus.configure(backend: :memory)
else
  MessageBus.configure({
    backend: :postgres,
    backend_options: ENV["MESSAGE_BUS_PG_CONNECTION_STRING"],
  })
end
