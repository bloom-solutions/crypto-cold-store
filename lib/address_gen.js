let bitcoin = require('bitcoinjs-lib')

let pubKeys = process.argv[2].split(",").sort().map(function (hex) { return Buffer.from(hex, 'hex') })
let signaturesRequired = parseInt(process.argv[3])

var redeemScript = bitcoin.script.multisig.output.encode(signaturesRequired, pubKeys)
var scriptPubKey = bitcoin.script.scriptHash.output.encode(bitcoin.crypto.hash160(redeemScript))
var address = bitcoin.address.fromOutputScript(scriptPubKey)

console.log(address)
