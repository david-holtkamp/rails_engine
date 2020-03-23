class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :items

  validates_presence_of :name

  def self.most_revenue(quantity_limit)
    joins(invoice_items: :transactions)
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .merge(Transaction.successful)
    .order(revenue: :desc)
    .limit(quantity_limit)
  end

end
