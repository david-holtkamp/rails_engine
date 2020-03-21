require_relative 'modules/priceable'

class InvoiceItem < ApplicationRecord
  include Priceable

  # before_validation :convert_to_dollars
end
