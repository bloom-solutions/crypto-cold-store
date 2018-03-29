module Btc
  class ImportAddressJob

    include Sidekiq::Worker

    def perform(public_address)
      ImportAddress.(public_address)
    end

  end
end
