require 'rails_helper'

RSpec.describe 'Items API' do
  it 'can find a single item record by its id' do
    id_1 = create(:item).id
    id_2 = create(:item).id

    get "/api/v1/items/find?id=#{id_2}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']
    expect(item['attributes']['id']).to eq(id_2)
  end

  it 'can find a single item by name' do
    item_1 = create(:item, name: "Item 1")
    item_2 = create(:item, name: "Item 2")

    get "/api/v1/items/find?name=#{item_1.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(item_1.id)
  end

  it 'is case insensitive for name' do
    item_1 = create(:item)
    name = item_1.name.downcase

    get "/api/v1/items/find?name=#{name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(item_1.id)
  end

  it 'can find a single item by description' do
    item_1 = create(:item, description: "Item 1")
    item_2 = create(:item, description: "Item 2")

    get "/api/v1/items/find?description=#{item_1.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(item_1.id)
  end

  it 'is case insensitive for description' do
    item_1 = create(:item)
    description = item_1.description.downcase

    get "/api/v1/items/find?description=#{description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(item_1.id)
  end

  it 'can find a single item by unit price' do
    item_1 = create(:item, unit_price: 28.12)
    item_2 = create(:item, unit_price: 22.33)

    get "/api/v1/items/find?unit_price=#{item_1.unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(item_1.id)
  end

  it 'can find a single item item by merchant id' do
    merchant = create(:merchant)

    item_1 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?item_id=#{item_1.merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(item_1.id)
  end

  it 'it can find a single item item based on created_at date' do
    item_1 = create(:item, created_at: "2020-01-29 14:53:59 UTC")
    item_2 = create(:item, created_at: "1938-05-13 12:53:59 UTC")

    get "/api/v1/items/find?created_at=#{item_1.created_at}"

    expect(response).to be_successful

    json_item = JSON.parse(response.body)['data']

    expect(json_item['attributes']['id']).to eq(item_1.id)
  end

  it 'it can find a single item item based on updated_at date' do
    item_1 = create(:item, created_at: "2020-01-29 14:53:59 UTC")
    item_2 = create(:item, created_at: "1938-05-13 12:53:59 UTC")

    get "/api/v1/items/find?updated_at=#{item_1.updated_at}"

    expect(response).to be_successful

    json_item = JSON.parse(response.body)['data']

    expect(json_item['attributes']['id']).to eq(item_1.id)
  end

  it 'returns null when record does not exist' do

    get "/api/v1/items/find?id=5000"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_falsey

    get "/api/v1/items/find?name=test"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_falsey

    get "/api/v1/items/find?description=test"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_falsey

    get "/api/v1/items/find?unit_price=9000"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_falsey

    get "/api/v1/items/find?merchant_id=5000"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_falsey

    get "/api/v1/items/find?created_at=10"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_falsey

    get "/api/v1/items/find?updated_at=10"

    expect(response).to be_successful
    json_item = JSON.parse(response.body)
    expect(json_item['data']).to be_falsey
  end

  it 'can return items based on a string fragment' do
    item_1 = create(:item, name: "string")
    item_2 = create(:item, name: "sting")
    item_3 = create(:item, name: "ting")

    search_params = 'ing'

    get "/api/v1/items/find?name=#{search_params}"

    expect(response).to be_successful
    item = JSON.parse(response.body)['data']['attributes']
    expect(item["name"]).to eq(item_1.name)
  end
end
