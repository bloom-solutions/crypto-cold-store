module Btc
  class ImportAddress

    extend LightService::Organizer

    def self.call(public_address)
      with(public_address: public_address).reduce(
        InitBitcoinerClient,
        SendImportRequest,
      )
    end

  end
end
