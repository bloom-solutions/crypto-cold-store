module Btc
  class SaveTxInfo

    extend LightService::Action
    expects :remote_tx, :remote_tx_output, :address
    promises :tx

    executed do |c|
      tx = c.address.txs.where(tx_id: c.remote_tx["txid"]).first_or_initialize

      block = c[:block]
      confirmations = block&.confirmations || 0

      tx.block_hash = block&.block_hash
      tx.confirmations = confirmations
      tx.amount = c.remote_tx_output["value"]

      c.skip_remaining! unless tx.changed?

      tx.save!

      c.tx = tx
    end

  end
end
