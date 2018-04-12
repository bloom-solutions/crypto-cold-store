module Btc
  class SaveTxInfo

    extend LightService::Action
    expects :block, :remote_tx, :remote_tx_output, :address, :block_index
    promises :tx

    executed do |c|
      tx = c.address.txs.where(tx_id: c.remote_tx["txid"]).first_or_initialize
      tx.update_attributes(
        block_hash: c.block.block_hash,
        confirmations: c.block.confirmations,
        amount: c.remote_tx_output["value"],
        block_index: c.block_index,
      )

      c.tx = tx
    end

  end
end
