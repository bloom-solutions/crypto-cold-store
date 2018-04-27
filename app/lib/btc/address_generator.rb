module Btc
  class AddressGenerator

    attr_reader :xpub, :signatures_required

    def initialize(xpub:, signatures_required: nil)
      @xpub = Array(xpub)
      @signatures_required = signatures_required.to_i

      return if @xpub.count == 1

      if @signatures_required.to_i.zero?
        fail ArgumentError, "because xpub is an array of multiple keys, signatures_required must be a valid number"
      elsif @signatures_required > @xpub.count
        fail ArgumentError, "signatures_required must be less or equal to the number of xpub"
      end
    end

    def address(idx)
      return multisig_address(idx) if xpub.count > 1
      single_address(idx)
    end

    private

    def multisig_address(idx)
      keychain_group = BTC::KeychainGroup.new(extended_keys: xpub)
      multisig_script = keychain_group.multisig_script({
        index: idx,
        signatures_required: self.signatures_required,
      })
      multisig_script.p2sh_script.standard_address.to_s
    end

    def single_address(idx)
      keychain = BTC::Keychain.new(xpub: xpub[0])
      keychain.derived_key(idx).address.to_s
    end

  end
end
