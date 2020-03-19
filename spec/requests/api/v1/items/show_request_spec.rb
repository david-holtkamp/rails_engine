require 'rails_helper'

RSpec.describe 'Items API' do
  it 'can get one item by its id' do
    Item.destroy_all
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)['data']
    expect(item['attributes']['id']).to eq(id)
  end
end
