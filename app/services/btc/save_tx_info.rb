module Btc
  class SaveTxInfo

    extend LightService::Action
    expects :remote_tx, :address
    promises :tx

    executed do |c|
      tx = c.address.txs.where(tx_id: c.remote_tx["txid"]).first_or_initialize
      tx.update_attributes(
        confirmations: c.remote_tx["confirmations"],
        amount: c.remote_tx["amount"],
        block_index: c.remote_tx["blockindex"],
      )

      c.tx = tx
    end

  end
end
