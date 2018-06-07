# README

[![Build Status](https://travis-ci.org/bloom-solutions/crypto-cold-store.svg?branch=master)](https://travis-ci.org/bloom-solutions/crypto-cold-store)

Crypto Cold Store is an open-source solution for cryptocurrency cold storage. Its job is simple:

- generate new addresses for every unique `code` passed to it
- publish in `/deposits` channel of new deposits or updates to them (up to a certain amount of confirmations depending on the coin)

## Coins Supported

- [Bitcoin](docs/bitcoin.md)
- [Ethereum](docs/ethereum.md)

## Generating Addresses

See `spec/requests/deposit_details_spec.rb`.

## Subscribing to notifications

[MessageBus](https://github.com/SamSaffron/message_bus) is used to publish notifications. See that repository for instructions on how to connect.

## Testing

Writing and re-running functional tests are more difficult, especially when having to deal with blockchains that are slow to load. When re-recording VCR cassettes, the test suite assumes that the blockchain nodes are accessible from this instance. Furthermore:

## Customizing

Customization is done through setting environment variables. For coin-specific variables, see the [Coins Supported](#coins-supported) section. Here you will find generic variables:

- `DB_POOL` is the maximum number of db connections (per Rails process) will be opened
- `SECRET_KEY_BASE` ([Rails setting](https://stackoverflow.com/questions/25426940/what-is-the-use-of-secret-key-base-in-rails-4/25427302))
- `DATABASE_URL` is the connection string to PostgreSQL
- `SIDEKIQ_USERNAME` & `SIDEKIQ_PASSWORD`: these protect the Sidekiq dashboard at `/sidekiq`. If not set, the dashboard will not be mounted.
- `SIDEKIQ_CONCURRENCY` controls how many Sidekiq workers are created per Sidekiq/Rails process
- `RAILS_LOG_TO_STDOUT` can be any non-nil value to print out the logs to `STDOUT`
- MessageBus:
  - `MESSAGE_BUS_PG_CONNECTION_STRING` is the connection string in this format: `dbname=db-name user=db-user password=db-pass host=db-host`
  - there are more variables you can find in `config/initializers/message_bus.rb`
- There are variables specific to puma, the web server. Those can be found in `config/puma.rb`
