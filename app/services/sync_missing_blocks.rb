class SyncMissingBlocks

  extend LightService::Organizer

  def self.call(coin)
    reduce(actions_for(coin))
  end

  private

  def self.actions_for(coin)
    case coin
    when "btc"
      [
        InitBitcoinerClient,
        execute(->(c) {c[:blocks] = Block.btc}),
        DetectBlockGaps,
        Btc::GetBlocksHashes,
        Btc::GetRemoteBlocks,
        iterate(:remote_blocks, [
          Btc::DeleteForkedBlock,
          Btc::SaveBlockInfo,
        ]),
        Btc::GetRemoteBlocksTxs,
        Btc::ProcessRemoteTxs,
      ]
    when "eth"
      [
        execute(->(c) {c[:blocks] = Block.eth}),
        DetectBlockGaps,
        iterate(:unsynced_blocks, [
          Eth::EnqueueSyncBlockJob,
        ])
      ]
    end
  end

end
