module Btc
  class GetBlocksToSync

    extend LightService::Action
    expects :blocks, :current_block_number
    promises :unsynced_blocks

    executed do |c|
      insufficiently_confirmed_blocks = c.blocks.order(height: :asc)

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
