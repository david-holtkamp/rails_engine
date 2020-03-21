require 'rails_helper'

RSpec.describe 'Items API' do
  it "can create a new item" do
    merchant = create(:merchant)

    post "/api/v1/items", params: {name: "Saw",
                    description: "I want to play a game",
                    unit_price: "87.50",
                    merchant_id: "#{merchant.id}"}

    expect(response).to be_successful
    json_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    item = Item.last

    expect(item.name).to eq(json_item[:name])
  end
end
