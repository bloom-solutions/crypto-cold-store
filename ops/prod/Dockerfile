FROM ruby:2.7.0
MAINTAINER Ramon Tayag <ramon.tayag@gmail.com>

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  curl -sL https://deb.nodesource.com/setup_10.x | bash && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get install -y \
  apt-transport-https \
  ca-certificates \
  build-essential \
  libpq-dev  \
  postgresql-client \
  nodejs \
  yarn

# Keep image size small:
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV APP=/app
RUN mkdir $APP
WORKDIR $APP

ENV BUNDLE_GEMFILE=$APP/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle \
  PATH=./bin:$PATH \
  RAILS_ENV=production \
  # To get it to compile
  SECRET_KEY_BASE=secret_key_base

RUN mkdir $BUNDLE_PATH

ADD Gemfile $APP/Gemfile
ADD Gemfile.lock $APP/Gemfile.lock

RUN gem update --system 3.1.3 && gem update --system && \
  gem install bundler:2.1.4 && \
  bundle install --jobs 20 --retry 5 --without development test

ADD . $APP

RUN cp $APP/config/database.yml.prod $APP/config/database.yml && \
  bundle exec rails assets:precompile
