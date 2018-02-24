module Api
  module V1
    class DepositDetailRepresenter < ApplicationRepresenter

      include Representable::JSON
      property :address
      property :min

    end
  end
end
