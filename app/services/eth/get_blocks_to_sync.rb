module Eth
  class GetBlocksToSync

    MAX_CONFS = 20
    extend LightService::Action
    expects :current_block_number
    promises :unsynced_blocks

    executed do |c|
      tx = ::Tx.of_coin(:eth).order(block_index: :asc).last

      if tx.present?
        low_conf_tx_block_indices = ::Tx.of_coin(:eth).
          with_confirmations_less_than(MAX_CONFS).
          pluck(:block_index)

        min = [tx.block_index, c.current_block_number - MAX_CONFS].min
        c.unsynced_blocks =
          (low_conf_tx_block_indices + (min..c.current_block_number).to_a).uniq
      else
        min = c.current_block_number - MAX_CONFS
        c.unsynced_blocks = min..c.current_block_number
      end
    end

  end
end
