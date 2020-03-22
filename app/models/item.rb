require_relative 'modules/priceable'

class Item < ApplicationRecord
  include Priceable

  # before_validation :convert_to_dollars
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoice
  validates_presence_of :name, :description, :unit_price, :merchant_id
end
