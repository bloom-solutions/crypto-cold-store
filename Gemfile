source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.7.6"

gem "addressable", "~> 2.8"
gem "bip44", "0.2.14"
gem "bitcoiner", "0.1.4"
gem "btcruby", github: "bloom-solutions/btcruby", branch: "bloom_changes"
gem "bugsnag", "~> 6.9"
gem "circuitbox", "~> 1.1"
gem "dry-initializer", "~> 2.3"
gem "dry-types" # required by reform coercion
gem "dry-validation"
gem "ethereum.rb", "~> 2.2"
gem "light-service", "0.10.2"
gem "lograge", "0.11.2"
gem "message_bus", "~> 2.1"
gem "pg", "~> 1.2"
gem "sidekiq", "~> 5.2"
gem "sidekiq-cron", "~> 1.0"
gem "sidekiq-failures", "~> 1.0"
gem "sidekiq-unique-jobs", "~> 6.0"
gem "sidekiq_alive", "~> 1.0"
gem "trailblazer-rails", "~> 2.0"
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 4.3'
gem 'rails', '~> 5.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'rspec-rails', '~> 3.7'
  gem 'selenium-webdriver', '~> 3.14'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem "rspec-sidekiq"
  gem "shoulda-matchers", "4.0.0.rc1"
  gem "timecop"
  gem "vcr"
  gem "webmock"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
