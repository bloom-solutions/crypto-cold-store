class Address < ApplicationRecord

  enum coin: {
    btc: 0,
    ltc: 1,
    eth: 2,
  }

  has_many :txs

end
