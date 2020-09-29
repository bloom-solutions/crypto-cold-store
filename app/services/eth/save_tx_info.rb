module Eth
  class SaveTxInfo

    ETHER_IN_WEI = BigDecimal("1_000_000_000_000_000_000.0")
    extend LightService::Action
    expects :address, :remote_tx
    promises :tx

    executed do |c|
      tx_id = c.remote_tx["hash"]
      block = c[:block]
      confirmations = block&.confirmations || 0
      tx = c.address.txs.where(tx_id: tx_id).first_or_initialize
      tx.tx_id = tx_id
      tx.confirmations = confirmations
      tx.amount = c.remote_tx["value"].to_i(16) / ETHER_IN_WEI
      tx.block_hash = block&.block_hash

      c.skip_remaining! unless tx.changed?

      tx.save!
      c.tx = tx
    end

  end
end
