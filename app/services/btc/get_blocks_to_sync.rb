module Btc
  class GetBlocksToSync

    MAX_CONFS = 10
    extend LightService::Action
    expects :blocks, :current_block_number
    promises :unsynced_blocks

    executed do |c|
      insufficiently_confirmed_blocks = c.blocks.
        with_confirmations_less_than(MAX_CONFS).
        order(height: :asc)

      if block = insufficiently_confirmed_blocks.first
        c.unsynced_blocks = Array(block.height..c.current_block_number)
      elsif block = c.blocks.order(height: :asc).last
        c.unsynced_blocks = (block.height..c.current_block_number).to_a
      else
        c.unsynced_blocks = Array(c.current_block_number)
      end
    end

  end
end
