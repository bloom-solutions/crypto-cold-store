module Btc
  module GetRemoteTxs

    extend LightService::Action
    expects :bitcoiner_client
    promises :remote_txs

    ACCOUNT = "*"
    DEFAULT_PER_PAGE = 10
    INCLUDE_WATCHONLY = true
    MAX_CONFS = 10

    executed do |c|
      c.remote_txs = self.of_interest(bitcoiner_client: c.bitcoiner_client)
    end

    def self.of_interest(bitcoiner_client:, count: DEFAULT_PER_PAGE, skip: 0)
      tx = Tx.with_confirmations_less_than(MAX_CONFS).
        order(created_at: :desc).last

      until_txid({
        bitcoiner_client: bitcoiner_client,
        txid: tx.tx_id,
        count: count,
        skip: skip,
      })
    end

    def self.until_txid(bitcoiner_client:, txid:, count: DEFAULT_PER_PAGE, skip: 0)
      txs = []

      bitcoiner_client.request(
        "listtransactions",
        ACCOUNT,
        count,
        skip,
        INCLUDE_WATCHONLY,
      ).reverse.each do |tx|
        txs.unshift(tx)
        return txs if txid == tx["txid"]
      end

      self.until_txid(
        bitcoiner_client: bitcoiner_client,
        txid: txid,
        count: count,
        skip: skip + count,
      ) + txs
    end

  end
end
