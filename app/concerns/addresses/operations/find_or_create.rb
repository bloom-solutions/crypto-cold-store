module Addresses
  module Operations
    class FindOrCreate < ApplicationOperation

      step :find_model, fast_track: true
      step Model(Address, :new)
      step Contract::Build(constant: Contracts::FindOrCreate)
      step Contract::Validate()
      step :create_model!

      private

      def find_model(options, params:, **)
        address = Address.find_by(
          code: params[:code],
          coin: params[:coin],
        )
        options["model"] = address
        address.present? ? Railway.pass_fast! : true
      end

      def create_model!(options, params:, **)
        options["model"] = Addresses::Create.(params[:coin], params[:code]).
          address
      end

    end
  end
end
