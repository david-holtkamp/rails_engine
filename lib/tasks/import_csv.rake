require 'csv'

        
# bundle exec rake import_csv:csv_to_db

namespace :import_csv do
  desc "Import data from CSV"
  task csv_to_db: :environment do
    Customer.destroy_all
    Merchant.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    InvoiceItem.destroy_all
    Transaction.destroy_all

    csv_models = {
      'db/data/customers.csv' => Customer,
      'db/data/merchants.csv' => Merchant,
      'db/data/items.csv' => Item,
      'db/data/invoices.csv' => Invoice,
      'db/data/invoice_items.csv' => InvoiceItem,
      'db/data/transactions.csv' => Transaction,
    }

    csv_models.each do |csv, model|
      CSV.foreach(csv, headers: true) do |row|
        model.create!(row.to_hash)
      end
    end
  end
end
