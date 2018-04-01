# README

[![Build Status](https://travis-ci.org/ramontayag/crypto_cold_store-rails.svg?branch=master)](https://travis-ci.org/ramontayag/crypto_cold_store-rails)

Crypto Cold Store is an open-source solution for cryptocurrency cold storage. It's job is simple:

- generate new addresses for every unique `code` passed to it
- publish in `/deposits` channel of new deposits or updates to them (up to a certain amount of confirmations depending on the coin)

## Coins Supported

- Bitcoin

## Generating Addresses

See `spec/requests/deposit_details_spec.rb`.

## Subscribing to notifications

[MessageBus](https://github.com/SamSaffron/message_bus) is used to publish notifications. See that repository for instructions on how to connect.

## Testing

Writing and re-running functional tests are more difficult, especially when having to deal with blockchains that are slow to load. When re-recording VCR cassettes, the test suite assumes that the blockchain nodes are accessible from this instance. Furthermore:

- Bitcoin: that the testnet address `muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt` has been imported *and* the database has been reindexed (so that `listtransactions` shows its transactions)
