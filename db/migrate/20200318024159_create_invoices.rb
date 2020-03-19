class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      enable_extension 'citext'

      t.references :customer, foreign_key: true
      t.references :merchant, foreign_key: true
      t.citext :status
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
