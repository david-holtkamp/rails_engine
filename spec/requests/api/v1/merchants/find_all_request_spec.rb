require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can find all merchant records by id' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant_1.id}"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant[0]['attributes']['id']).to eq(merchant_1.id)
  end

  it 'can find all merchant records by name' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']

    expect(merchants.count).to eq(2)
    expect(merchants.first['attributes']['name']).to eq(merchant_1.name)
    expect(merchants.last['attributes']['name']).to eq(merchant_2.name)
  end

  it 'is case insensitive for name' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    name_1 = merchant_1.name.downcase
    name_2 = merchant_2.name.downcase

    get "/api/v1/merchants/find_all?name=#{name_1}"

    expect(response).to be_successful

    json_merchants = JSON.parse(response.body)['data']

    expect(json_merchants.count).to eq(2)
    expect(json_merchants.first['attributes']['id']).to eq(merchant_1.id)
    expect(json_merchants.last['attributes']['id']).to eq(merchant_2.id)
  end

  it 'can find all merchant records by created_at date' do
    merchant_1 = create(:merchant, created_at: "2020-01-29 14:53:59 UTC")
    merchant_2 = create(:merchant, created_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']

    expect(merchants.count).to eq(2)
    expect(merchants.first['attributes']['id']).to eq(merchant_1.id)
    expect(merchants.last['attributes']['id']).to eq(merchant_2.id)
  end

  it 'can find all merchant records by updated_at date' do
    merchant_1 = create(:merchant, updated_at: "2020-01-29 14:53:59 UTC")
    merchant_2 = create(:merchant, updated_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/merchants/find_all?updated_at=#{merchant_1.updated_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']

    expect(merchants.count).to eq(2)
    expect(merchants.first['attributes']['id']).to eq(merchant_1.id)
    expect(merchants.last['attributes']['id']).to eq(merchant_2.id)
  end

  it 'returns empty when record does not exist' do

    get "/api/v1/merchants/find_all?id=101"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_empty

    get "/api/v1/merchants/find_all?name=test"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_empty

    get "/api/v1/merchants/find_all?created_at=10"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_empty

    get "/api/v1/merchants/find_all?updated_at=10"

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body)
    expect(json_merchant['data']).to be_empty
  end

  it 'can return merchants based on a string fragment' do
    merchant_1 = create(:merchant, name: "string")
    merchant_2 = create(:merchant, name: "sting")
    merchant_3 = create(:merchant, name: "ting")

    search_params = 'ing'

    get "/api/v1/merchants/find_all?name=#{search_params}"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)['data']
    expect(merchants.count).to eq(3)
  end
end
