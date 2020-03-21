require 'rails_helper'

RSpec.describe 'Items API' do
  it 'can find all item records by id' do
    item_1 = create(:item)
    item_2 = create(:item)

    get "/api/v1/items/find_all?id=#{item_1.id}"

    expect(response).to be_successful

    json_items = JSON.parse(response.body)['data']

    expect(json_items[0]['attributes']['id']).to eq(item_1.id)
  end

  it 'can find all item records by name' do
    item_1 = create(:item, name: "Item")
    item_2 = create(:item, name: "Item")

    get "/api/v1/items/find_all?name=#{item_1.name}"

    expect(response).to be_successful

    json_items = JSON.parse(response.body)['data']

    expect(json_items.count).to eq(2)
    expect(json_items.first['attributes']['id']).to eq(item_1.id)
    expect(json_items.last['attributes']['id']).to eq(item_2.id)
  end

  it 'is case insensitive for name' do
    item_1 = create(:item)
    item_2 = create(:item)

    name_1 = item_1.name.downcase
    name_2 = item_2.name.downcase

    get "/api/v1/items/find_all?name=#{name_1}"

    expect(response).to be_successful

    json_items = JSON.parse(response.body)['data']

    expect(json_items.count).to eq(2)
    expect(json_items.first['attributes']['id']).to eq(item_1.id)
    expect(json_items.last['attributes']['id']).to eq(item_2.id)
  end

  it 'can find all item records by description' do
    item_1 = create(:item, description: "Item")
    item_2 = create(:item, description: "Item")

    get "/api/v1/items/find_all?description=#{item_1.description}"

    expect(response).to be_successful

    json_items = JSON.parse(response.body)['data']

    expect(json_items.count).to eq(2)
    expect(json_items.first['attributes']['id']).to eq(item_1.id)
    expect(json_items.last['attributes']['id']).to eq(item_2.id)
  end

  it 'is case insensitive for description' do
    item_1 = create(:item)
    item_2 = create(:item)

    description_1 = item_1.description.downcase
    description_2 = item_2.description.downcase

    get "/api/v1/items/find_all?description=#{description_1}"

    expect(response).to be_successful

    json_items = JSON.parse(response.body)['data']

    expect(json_items.count).to eq(2)
    expect(json_items.first['attributes']['id']).to eq(item_1.id)
    expect(json_items.last['attributes']['id']).to eq(item_2.id)
  end

  it 'can find all item records by unit price' do
    item_1 = create(:item, unit_price: "12.13")
    item_2 = create(:item, unit_price: "12.13")
    item_3 = create(:item, unit_price: "43.23")

    get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"

    expect(response).to be_successful

    json_items = JSON.parse(response.body)['data']

    expect(json_items.count).to eq(2)
    expect(json_items.first['attributes']['id']).to eq(item_1.id)
    expect(json_items.last['attributes']['id']).to eq(item_2.id)
  end

  it 'can find all item records by merchant id' do
    merchant = create(:merchant)

    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']

    expect(items.count).to eq(2)
    expect(items.first['attributes']['merchant_id']).to eq(item_1.merchant_id)
    expect(items.last['attributes']['merchant_id']).to eq(item_2.merchant_id)
  end

  it 'can find all item records by created_at date' do
    item_1 = create(:item, created_at: "2020-01-29 14:53:59 UTC")
    item_2 = create(:item, created_at: "2020-01-29 14:53:59 UTC")
    item_3 = create(:item, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']

    expect(items.count).to eq(2)
    expect(items.first['attributes']['id']).to eq(item_1.id)
    expect(items.last['attributes']['id']).to eq(item_2.id)
  end

  it 'can find all item records by updated_at date' do
    item_1 = create(:item, updated_at: "2020-01-29 14:53:59 UTC")
    item_2 = create(:item, updated_at: "2020-01-29 14:53:59 UTC")
    item_3 = create(:item, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']

    expect(items.count).to eq(2)
    expect(items.first['attributes']['id']).to eq(item_1.id)
    expect(items.last['attributes']['id']).to eq(item_2.id)
  end

  it 'returns empty when record does not exist' do

    get "/api/v1/items/find_all?id=1000"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_empty

    get "/api/v1/items/find_all?name=test"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_empty

    get "/api/v1/items/find_all?description=test"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_empty

    get "/api/v1/items/find_all?unit_price=9000"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_empty

    get "/api/v1/items/find_all?merchant_id=1000"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_empty

    get "/api/v1/items/find_all?updated_at=10"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_empty
  end


    it 'can return items based on a string fragment' do
      item_1 = create(:item, name: "string")
      item_2 = create(:item, name: "sting")
      item_3 = create(:item, name: "ting")

      search_params = 'ing'

      get "/api/v1/items/find_all?name=#{search_params}"

      expect(response).to be_successful
      items = JSON.parse(response.body)['data']
      expect(items.count).to eq(3)
    end
end
