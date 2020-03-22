require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can find a single merchant record by its id' do
    id_1 = create(:merchant).id
    id_2 = create(:merchant).id
    id_3 = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id_2}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes']['id']).to eq(id_2)
  end

  it 'can find a single merchant by its name' do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes']['name']).to eq(name)
  end

  it 'is case insensitive for name' do
    merchant = create(:merchant)
    name = merchant.name.downcase

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant['attributes']['id']).to eq(merchant.id)
  end

  it 'it can find a single merchant based on created_at date' do
    merchant = create(:merchant, created_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant['attributes']['id']).to eq(merchant.id)
  end

  it 'it can find a single merchant based on updated_at date' do
    merchant = create(:merchant, updated_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant['attributes']['id']).to eq(merchant.id)
  end

  it 'returns null when record does not exist' do

    get "/api/v1/merchants/find?id=101"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_falsey

    get "/api/v1/merchants/find?name=test"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_falsey

    get "/api/v1/merchants/find?created_at=10"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_falsey

    get "/api/v1/merchants/find?updated_at=10"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_falsey
  end

  it 'can find a single merchant by a string fragment' do
    merchant_create = create(:merchant, name: "Billy")

    search_params = 'lly'

    get "/api/v1/merchants/find?name=#{search_params}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']['attributes']
    expect(merchant["name"]).to eq(merchant_create.name)
  end
end
