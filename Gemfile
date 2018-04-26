source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'sqlite3'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "lograge", "0.10.0"
gem "sidekiq", "~> 5.1"
gem "sidekiq-failures", "~> 1.0"
gem "sidekiq-cron", "0.6.3"
gem "sidekiq-unique-jobs", "~> 5.0"
gem "dry-initializer", "~> 2.3"
gem "dry-types" # required by reform coercion
gem "dry-validation"
gem "trailblazer-rails", "~> 2.0"
gem "pg", "0.21.0"
gem "bitcoiner", github: "bloom-solutions/bitcoiner", branch: "all_features"
gem "light-service", "0.10.2"
gem "addressable", "~> 2.5"
gem "message_bus", "~> 2.1"
gem "btcruby", "~> 1.7"
gem "ethereum.rb", "~> 2.2"
gem "bip44", "0.2.14"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'rspec-rails', '~> 3.7'
  gem 'selenium-webdriver'
  gem "pry-byebug"
  gem "dotenv-rails"
  gem "factory_bot_rails"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "vcr"
  gem "webmock"
  gem "timecop"
  gem "rspec-sidekiq"
  gem "shoulda-matchers", github: "thoughtbot/shoulda-matchers" # for `optional`
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
