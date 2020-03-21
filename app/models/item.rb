require_relative 'modules/priceable'

class Item < ApplicationRecord
  include Priceable

  # before_validation :convert_to_dollars
  belongs_to :merchant
  validates_presence_of :name, :description, :unit_price, :merchant_id
end
