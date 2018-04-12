FactoryBot.define do

  factory :tx do
    address
    block
    sequence(:tx_id) { |n| "tx#{n}" }
    sequence(:block_index) { |n| n }
  end

end
