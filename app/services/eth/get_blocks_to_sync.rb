module Eth
  class GetBlocksToSync

    MAX_CONFS = 150
    extend LightService::Action
    expects :blocks, :current_block_number
    promises :unsynced_blocks

    executed do |c|
      block_heights_with_insufficient_confirmations = c.blocks.
        with_confirmations_less_than(MAX_CONFS).
        order(height: :asc)
      earliest_insufficiently_confirmed_block =
        block_heights_with_insufficient_confirmations.first

      if earliest_insufficiently_confirmed_block.present?
        c.unsynced_blocks =
          earliest_insufficiently_confirmed_block.height..c.current_block_number
      else
        c.unsynced_blocks = [c.current_block_number]
      end
    end

  end
end
