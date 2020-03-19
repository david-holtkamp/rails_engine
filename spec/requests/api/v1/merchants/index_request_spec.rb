require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'returns an index of all merchant records' do
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']
    expect(merchants.count).to eq(10)
  end
end
