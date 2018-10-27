require 'sidekiq/api'
require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq_unique_jobs/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :deposit_detail, only: %i[show]
    end
  end

  sidekiq_username = ENV.fetch("SIDEKIQ_USERNAME") { nil }
  sidekiq_password = ENV.fetch("SIDEKIQ_PASSWORD") { nil }

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    given_username_hash = ::Digest::SHA256.hexdigest(username)
    username_hash = ::Digest::SHA256.hexdigest(sidekiq_username)
    given_password_hash = ::Digest::SHA256.hexdigest(password)
    password_hash = ::Digest::SHA256.hexdigest(sidekiq_password)

    username_comparison = ActiveSupport::SecurityUtils.
      secure_compare(given_username_hash, username_hash)
    password_comparison = ActiveSupport::SecurityUtils.
      secure_compare(given_password_hash, password_hash)

    username_comparison & password_comparison
  end if Rails.env.production?

  if sidekiq_username.present? && sidekiq_password.present? ||
      !Rails.env.production?
    mount Sidekiq::Web => '/sidekiq'
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
