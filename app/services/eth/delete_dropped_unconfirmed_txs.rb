module Eth
  class DeleteDroppedUnconfirmedTxs

    extend LightService::Action
    expects :remote_txs

    executed do |c|
      tx_ids = c.remote_txs.map {|remote_tx| remote_tx["hash"]}
      txs = ::Tx.of_coin(:eth).where.not(tx_id: tx_ids).where(confirmations: 0)
      txs.find_each(&:destroy)
    end

  end
end
