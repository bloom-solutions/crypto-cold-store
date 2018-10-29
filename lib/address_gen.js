let bitcoin = require('bitcoinjs-lib')

const pubkeys = process.argv[2].split(",").sort().map(
  (hex) => Buffer.from(hex, 'hex')
)

const signaturesRequired = parseInt(process.argv[3])

const { address } = bitcoin.payments.p2sh({
  redeem: bitcoin.payments.p2ms({ m: signaturesRequired, pubkeys })
})

console.log(address)
