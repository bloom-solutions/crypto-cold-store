class Tx < ApplicationRecord

  belongs_to :address

  scope :with_confirmations_less_than, ->(n) do
    confirmations = arel_table[:confirmations]
    where(confirmations.lt(n))
  end

end
