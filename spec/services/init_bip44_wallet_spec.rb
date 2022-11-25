require 'rails_helper'

RSpec.describe InitBip44Wallet do

  let(:master_public_key) do
    "wM5uZBV4LrG2YawGW8wBUgSmGPyA8WTsfQFBeSjWV2uN4iFHxgRzg9Xoku1kkHSoq67JKz3hapa9VfAK4Co2Mn5ZdmP63tHqP4BiXqL5VqzCGUqG"
  end

  xit "sets a bip44_wallet with the master_public_key in the ctx" do
    resulting_ctx = described_class.execute(master_public_key: master_public_key)

    bip44_wallet = resulting_ctx.bip44_wallet

    expect(bip44_wallet).to be_a Bip44::Wallet
    expect(bip44_wallet.get_ethereum_address("0")).
      to eq "0x9c282c8602a10E30baa14850676d728205C0B7D0".downcase
    expect(bip44_wallet.get_ethereum_address("4")).
      to eq "0x86D7984843C3079eaf467Ef73eDA7a79621d867B".downcase
  end
end
