require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)['data']
    expect(merchant['attributes']['id']).to eq(id)
  end
end
