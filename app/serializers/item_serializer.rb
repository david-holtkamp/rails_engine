class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :merchant_id
  attribute :unit_price do |item|
    item.unit_price.to_f
  end
end
