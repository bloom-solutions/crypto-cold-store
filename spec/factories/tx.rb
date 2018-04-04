FactoryBot.define do

  factory :tx do
    address
    sequence(:tx_id) { |n| "tx#{n}" }
    sequence(:block_index) { |n| n }
  end

end
