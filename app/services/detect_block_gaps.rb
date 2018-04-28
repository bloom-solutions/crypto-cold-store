class DetectBlockGaps

  extend LightService::Action
  expects :blocks
  promises :unsynced_blocks

  SEARCH_INCREMENT = 1_000

  executed do |c|
    blocks = c.blocks.order(height: :asc)
    start_height = blocks.first.height
    limit = blocks.last.height
    c.unsynced_blocks = get_missing_blocks_in(blocks, start_height, limit)
  end

  def self.get_missing_blocks_in(blocks, start_height, limit)
    return [] if start_height >= limit

    end_height = start_height + SEARCH_INCREMENT
    end_height = limit if end_height > limit

    scoped_blocks = blocks.
      with_height_gteq(start_height).
      with_height_lteq(end_height)

    missing_block_heights =
      (start_height..end_height).to_set - scoped_blocks.pluck(:height).to_set

    missing_block_heights.to_a +
      get_missing_blocks_in(blocks, end_height+1, limit)
  end

end
