let bitcoin = require('bitcoinjs-lib')

const network = (process.argv[2] == "testnet") ? bitcoin.networks.testnet : bitcoin.networks.bitcoin

const pubkeys = process.argv[3].split(",").sort().map(
  (hex) => Buffer.from(hex, 'hex')
)

const signaturesRequired = parseInt(process.argv[4])

const { address } = bitcoin.payments.p2sh({
  network: network,
  redeem: bitcoin.payments.p2ms({ network: network, m: signaturesRequired, pubkeys })
})

console.log(address)
