FactoryBot.define do

  factory :tx do
    address
    block
    sequence(:tx_id) { |n| "tx#{n}" }
  end

end
