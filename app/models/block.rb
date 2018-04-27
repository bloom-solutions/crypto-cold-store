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

  scope :with_height_greater_than_or_equal_to, ->(height) do
    where(arel_table[:height].gteq(height))
  end

  scope :with_height_less_than_or_equal_to, ->(height) do
    where(arel_table[:height].lteq(height))
  end

  class << self
    alias :with_height_gteq :with_height_greater_than_or_equal_to
    alias :with_height_lteq :with_height_less_than_or_equal_to
  end

end
