# README

[![Build Status](https://travis-ci.org/ramontayag/crypto_cold_store-rails.svg?branch=master)](https://travis-ci.org/ramontayag/crypto_cold_store-rails)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Testing

Writing and re-running functional tests are more difficult, especially when having to deal with blockchains that are slow to load. When re-recording VCR cassettes, the test suite assumes that the blockchain nodes are accessible from this instance. Furthermore:

- Bitcoin: that the testnet address `muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt` has been imported *and* the database has been reindexed (so that `listtransactions` shows its transactions)
