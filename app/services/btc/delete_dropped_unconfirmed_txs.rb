module Btc
  class DeleteDroppedUnconfirmedTxs

    extend LightService::Action
    expects :tx_ids

    executed do |c|
      txs = Tx.of_coin(:btc).where.not(tx_id: c.tx_ids).where(confirmations: 0)
      txs.find_each(&:destroy)
    end

  end
end
