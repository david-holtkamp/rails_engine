require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'returns an index of all merchant items' do
    id = create(:merchant).id
    item_1 = create(:item, merchant_id: id)
    item_2 = create(:item, merchant_id: id)
    item_3 = create(:item, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful
    merchant_items = JSON.parse(response.body)['data']
    
    expect(merchant_items.count).to eq(3)
    expect(merchant_items.first['attributes']['merchant_id']).to eq(id)
  end
end
