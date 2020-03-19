FactoryBot.define do
  factory :item do
    name { "Useful Item" }
    description { "Apocalypse prep tools." }
    unit_price { "12345" }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
    merchant
  end
end
