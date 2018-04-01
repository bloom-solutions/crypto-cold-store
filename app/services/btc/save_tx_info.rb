module Btc
  class SaveTxInfo

    extend LightService::Action
    expects :remote_tx, :address
    promises :tx

    executed do |c|
      tx = c.address.txs.where(
        tx_id: c.remote_tx["txid"],
        amount: c.remote_tx["amount"],
      ).first_or_initialize

      tx.update_attributes(confirmations: c.remote_tx["confirmations"])

      c.tx = tx
    end

  end
end
