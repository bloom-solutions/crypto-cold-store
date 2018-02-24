class DepositDetail

  extend Dry::Initializer
  option :address, type: Types::Coercible::String, optional: true
  option :min, type: Types::Coercible::Float, optional: true
  attr_writer :address, :min

end
