class NotifyTxReceipt

  extend LightService::Action
  expects :tx

  CHANNEL = "/deposits"

  executed do |c|
    address = c.tx.address

    data = {
      coin: address.coin,
      code: address.code,
      tx_id: c.tx.tx_id,
      address: address.address,
      amount: c.tx.amount,
      confirmations: c.tx.confirmations,
      last_id: MessageBus.last_id(CHANNEL),
    }

    MessageBus.publish CHANNEL, data.to_json
  end

end
