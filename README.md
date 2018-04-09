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
