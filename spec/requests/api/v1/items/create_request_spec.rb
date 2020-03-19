require 'rails_helper'

RSpec.describe 'Items API' do
  it "can create a new item" do
    merchant = create(:merchant)

    item_params = { name: "Saw",
                    description: "I want to play a game",
                    unit_price: 87.50,
                    merchant_id: merchant.id}

    post "/api/v1/items", params: {item: item_params}
    item = Item.last
    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end
end
