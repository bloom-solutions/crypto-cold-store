FactoryBot.define do

  factory :address do
    coin { Address.coins.keys.sample.to_s }
    sequence(:address) { |n| "addr#{n}" }
    sequence(:code) { |n| n }
  end

end
