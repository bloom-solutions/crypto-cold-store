class SyncMissingBlocks

  extend LightService::Organizer

  def self.call(coin)
    reduce(actions_for(coin))
  end

  private

  def self.actions_for(coin)
    coin_namespace = coin.classify.constantize
    [
      coin_namespace.const_get("SetBlocks"),
      DetectBlockGaps,
      iterate(:unsynced_blocks, [
        coin_namespace.const_get("EnqueueSyncBlockJob"),
      ])
    ]
  end

end
