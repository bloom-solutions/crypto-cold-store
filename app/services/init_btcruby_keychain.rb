class InitBtcrubyKeychain

  extend LightService::Action
  expects :master_public_key
  promises :keychain

  executed do |c|
    c.keychain = BTC::Keychain.new(xpub: c.master_public_key)
  end

end
