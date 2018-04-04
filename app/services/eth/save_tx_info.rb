module Eth
  class SaveTxInfo

    ETHER_IN_WEI = BigDecimal.new("1_000_000_000_000_000_000.0")
    extend LightService::Action
    expects :address, :remote_tx, :current_block_number
    promises :tx

    executed do |c|
      tx_id = c.remote_tx["hash"]
      confirmations =
        c.current_block_number - c.remote_tx["blockNumber"].to_i(16)

      tx = c.address.txs.where(tx_id: tx_id).first_or_initialize
      tx.update_attributes(
        tx_id: tx_id,
        confirmations: confirmations,
        amount: c.remote_tx["value"].to_i(16) / ETHER_IN_WEI,
        block_index: c.remote_tx["blockNumber"].to_i(16)
      )
      c.tx = tx
    end

  end
end
