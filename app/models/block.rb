class Block < ApplicationRecord

  COINS = {
    btc: 0,
    ltc: 1,
    eth: 2,
  }
  enum coin: COINS

  has_many :txs, primary_key: :block_hash, foreign_key: :block_hash

  scope :with_confirmations_less_than, ->(n) do
    confirmations = arel_table[:confirmations]
    where(confirmations.lt(n))
  end

end
