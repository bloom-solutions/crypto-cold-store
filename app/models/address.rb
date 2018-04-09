class Address < ApplicationRecord

  enum coin: Block::COINS

  has_many :txs

end
