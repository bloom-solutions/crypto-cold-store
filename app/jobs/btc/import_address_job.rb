module Btc
  class ImportAddressJob < ApplicationJob

    def perform(public_address)
      ImportAddress.(public_address)
    end

  end
end
