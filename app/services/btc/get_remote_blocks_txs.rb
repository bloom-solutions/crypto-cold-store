module Btc
  module GetRemoteBlocksTxs

    extend LightService::Action
    expects :bitcoiner_client, :remote_blocks
    promises :remote_txs

    executed do |c|
      c.remote_txs = c.remote_blocks.map do |remote_block|
        remote_block["tx"] || []
      end.flatten
    end

  end
end
