module Addresses
  class Create

    def self.call(coin, code)
      klass_for(coin).(code)
    end

    private

    def self.klass_for(coin)
      ::Addresses.const_get(coin.classify).const_get("Create")
    rescue NameError => e
      fail ArgumentError, "unknown handler for #{coin}"
    end

  end
end
