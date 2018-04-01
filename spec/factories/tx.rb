FactoryBot.define do

  factory :tx do
    address
    sequence(:tx_id) { |n| "tx#{n}" }
  end

end
