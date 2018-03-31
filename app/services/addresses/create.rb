module Addresses
  class Create

    def self.call(coin, code)
      klass_for(coin).(code)
    end

    private

    def self.klass_for(coin)
      "#{coin.classify.constantize}::Addresses::Create".constantize
    rescue NameError => e
      fail ArgumentError, "unknown handler for #{coin}"
    end

  end
end
