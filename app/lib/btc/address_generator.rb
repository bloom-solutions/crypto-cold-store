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
      keychains = xpub.map { |x| BTC::Keychain.new(extended_key: x) }
      keys = keychains.map { |keychain| keychain.derived_key(idx) }
      public_keys = keys.map { |key| BTC.to_hex(key.public_key) }.sort

      command = [
        "node",
        Rails.root.join("lib", "address_gen.js"),
        public_keys.join(","),
        signatures_required,
      ].join(" ")
      stdout_str, stderr_str, status = Open3.capture3(command)
      stdout_str.chomp
    end

    def single_address(idx)
      keychain = BTC::Keychain.new(xpub: xpub[0])
      keychain.derived_key(idx).address.to_s
    end

  end
end
