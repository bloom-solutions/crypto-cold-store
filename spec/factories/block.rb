FactoryBot.define do

  factory :block do
    coin "btc"
    sequence(:block_hash) {|n| "blockhash#{n}" }
    confirmations 30
    height 20_001
  end

end
