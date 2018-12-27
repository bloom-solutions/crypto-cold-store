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
        Btc::SetBlocks,
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
        Eth::SetBlocks,
        DetectBlockGaps,
        iterate(:unsynced_blocks, [
          Eth::EnqueueSyncBlockJob,
        ])
      ]
    end
  end

end
