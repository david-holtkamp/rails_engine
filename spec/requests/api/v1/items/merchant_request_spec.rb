require 'rails_helper'

RSpec.describe 'Items API' do
  it 'returns the merchant for a particular item' do
    id = create(:merchant).id
    item_1 = create(:item, merchant_id: id)

    get "/api/v1/items/#{item_1.id}/merchant"

    expect(response).to be_successful
    item_merchant = JSON.parse(response.body)['data']
    expect(item_merchant['attributes']['id']).to eq(id)
  end
end
