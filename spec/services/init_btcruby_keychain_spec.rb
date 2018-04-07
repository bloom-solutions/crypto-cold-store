require 'rails_helper'

RSpec.describe InitBtcrubyKeychain do

  let(:master_public_key) do
    "xpub6FMbbkESWrcdwWdJgfW4qPMF8JhjTbLgKoSjKofd6X5f1rjz1qm3N3nQ4DfFcz8SHPNrVq4RzfmvRG488LPY7d59r4Cp4bV7e7G6zvUA8MU"
  end

  it "places a #{BTC::Keychain} in the context with the master_public_key" do
    resulting_ctx = described_class.execute(master_public_key: master_public_key)

    keychain = resulting_ctx.keychain
    expect(keychain).to be_a(BTC::Keychain)
    expect(keychain.derived_key(0).address.to_s).
      to eq "1FTwdEtxdswwLmVeyAn8Rx8nVCVziRtVDs"
  end

end
