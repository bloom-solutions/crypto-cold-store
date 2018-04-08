module Btc
  class ImportAddressJob < ApplicationJob

    sidekiq_options retry: true

    def perform(public_address)
      ImportAddress.(public_address)
    end

  end
end
