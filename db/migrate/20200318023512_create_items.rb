class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      enable_extension 'citext'

      t.citext :name
      t.citext :description
      t.decimal :unit_price
      t.datetime :created_at
      t.datetime :updated_at
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
