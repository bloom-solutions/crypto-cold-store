module Btc
  class SaveTxInfo

    extend LightService::Action
    expects :remote_tx, :remote_tx_output, :address
    promises :tx

    executed do |c|
      tx = c.address.txs.where(tx_id: c.remote_tx["txid"]).first_or_initialize

      block = c[:block]
      confirmations = block&.confirmations || 0

      tx.update_attributes(
        block_hash: block&.block_hash,
        confirmations: confirmations,
        amount: c.remote_tx_output["value"],
      )

      c.tx = tx
    end

  end
end
