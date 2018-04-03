class InitBip44Wallet

  extend LightService::Action
  expects :master_public_key
  promises :bip44_wallet

  executed do |c|
    c.bip44_wallet = Bip44::Wallet.from_xpub(c.master_public_key)
  end

end
