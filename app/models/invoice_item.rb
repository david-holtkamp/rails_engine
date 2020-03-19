require_relative 'modules/priceable'

class InvoiceItem < ApplicationRecord
  include Priceable

  before_create :convert_to_dollars
end