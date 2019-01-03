module Btc
  class FilterBlockHashes

    extend LightService::Action
    expects :blocks, :block_hashes
    promises :block_hashes

    executed do |c|
      sufficiently_confirmed_blocks = c.blocks.
        with_confirmations_greater_than_or_equal_to(GetBlocksToSync::MAX_CONFS)
      sufficiently_confirmed_block_hashes = sufficiently_confirmed_blocks.
        pluck(:block_hash)

      c.block_hashes = c.block_hashes - sufficiently_confirmed_block_hashes
    end

  end
end
