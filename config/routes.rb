require 'sidekiq/api'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :deposit_detail, only: %i[show]
    end
  end

  match({
    "queue-status" => proc {
      [
        200,
        {"Content-Type" => "text/plain"},
        [Sidekiq::Queue.new.size < 100 ? "OK" : "UHOH"],
      ]
    },
    via: :get,
  })
end
