class Tx < ApplicationRecord

  belongs_to :address
  belongs_to(:block, {
    foreign_key: :block_hash,
    primary_key: :block_hash,
    optional: true,
  })

  scope :with_confirmations_less_than, ->(n) do
    confirmations = arel_table[:confirmations]
    where(confirmations.lt(n))
  end

  scope :of_coin, ->(coin) do
    joins(:address).where(addresses: {coin: Address.coins[coin]})
  end

end
