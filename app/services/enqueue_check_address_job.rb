class EnqueueCheckAddressJob

  extend LightService::Action
  expects :address

  executed do |c|
    CheckAddressJob.perform_async(
      c.address.coin,
      c.address.address,
      c.address.txs.pluck(:tx_hash),
    )
  end

end
