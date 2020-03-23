require 'rails_helper'

RSpec.describe 'Merchants API' do
  it "can create a new merchant" do

    post "/api/v1/merchants", params: {name: "Merry Merchant"}

    expect(response).to be_successful
    json_merchant = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    merchant = Merchant.last

    expect(merchant.name).to eq(json_merchant[:name])
  end
end
