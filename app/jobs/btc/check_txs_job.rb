module Btc
  class CheckTxsJob < ApplicationJob

    def perform
      CheckTxs.()
    end

  end
end
