require 'sidekiq/api'
require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :deposit_detail, only: %i[show]
    end
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    given_username_hash = ::Digest::SHA256.hexdigest(username)
    username_hash = ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])
    given_password_hash = ::Digest::SHA256.hexdigest(password)
    password_hash = ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"])

    username_comparison = ActiveSupport::SecurityUtils.
      secure_compare(given_username_hash, username_hash)
    password_comparison = ActiveSupport::SecurityUtils.
      secure_compare(given_password_hash, password_hash)

    username_comparison & password_comparison
  end if Rails.env.production?
  mount Sidekiq::Web => '/sidekiq'

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
