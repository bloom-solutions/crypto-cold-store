module Eth
  class EnqueueSyncBlockJob

    extend LightService::Action
    expects :unsynced_block

    executed do |c|
      SyncBlockJob.perform_async(c.unsynced_block)
    end

  end
end
