require_relative 'modules/priceable'

class InvoiceItem < ApplicationRecord
  include Priceable

  belongs_to :item
  belongs_to :invoice

  # before_validation :convert_to_dollars
end
