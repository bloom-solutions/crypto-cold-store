FROM ruby:2.7.6
MAINTAINER Ramon Tayag <ramon.tayag@gmail.com>

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

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

# Workaround for lack of new OpenSSL support https://github.com/oleganza/btcruby/issues/29
# But it requires changes in `bloom_changes` branch in https://github.com/bloom-solutions/btcruby
# that point to libssl.so.1.0.2 instead of 1.0.0
RUN ln -nfs /usr/lib/x86_64-linux-gnu/libssl.so.1.0.2 /usr/lib/libssl.so.1.0.2

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

RUN gem install --default bundler && \
  gem update --system  && \
  bundle update --bundler && \
  bundle install --jobs 20 --retry 5 --without development test

ADD . $APP

RUN cp $APP/config/database.yml.prod $APP/config/database.yml && \
  bundle exec rails assets:precompile
