require "btcruby"

def receiving_mpk_for(parent_mpk)
  keychain = BTC::Keychain.new(extended_key: parent_mpk)
  keychain.derived_keychain("0").xpub
end

puts receiving_mpk_for(ARGV[0])
