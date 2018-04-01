class Address < ApplicationRecord

  enum coin: {
    btc: 0,
    ltc: 1,
  }

  has_many :txs

end
