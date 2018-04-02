# Bitcoin

## Generating Addresses

If the environment variable `BTC_MASTER_PUBLIC_KEY` is supplied, the Bitcoin addresses will be generated from that master public key. If not, this app will attempt to connect to Electrum (in `ELECTRUM_HOST`) to generate new addresses.
