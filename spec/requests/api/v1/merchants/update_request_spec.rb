require 'rails_helper'

RSpec.describe 'Merchants API' do
  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name

    patch "/api/v1/merchants/#{id}", params: {name: "Sledge"}
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Sledge")
  end
end
