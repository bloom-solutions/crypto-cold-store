module Addresses
  module Contracts
    class FindOrCreate < ApplicationContract

      property :coin
      property :code

      validation do
        required(:coin).filled
        required(:code).filled
      end

    end
  end
end
