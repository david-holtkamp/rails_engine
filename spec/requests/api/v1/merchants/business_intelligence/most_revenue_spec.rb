require 'rails_helper'

describe 'Merchants with most revenue' do
  it 'returns X amount of merchants with the most revenue' do
    customer = create(:customer)
    merchant_1 = create(:merchant, name: 'Merchant 1')
    invoice_1 = Invoice.create(status: 'shipped', merchant_id: merchant_1.id, customer_id: customer.id)
    item_1 = merchant_1.items.create(name: 'Item 1', description: "I'm an item!", unit_price: 100)
    invoice_1.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100)
    invoice_1.transactions.create(credit_card_number: '1234567887654321', result: 'success')

    merchant_2 = create(:merchant, name: 'Merchant 2')
    invoice_2 = Invoice.create(status: 'shipped', merchant_id: merchant_2.id, customer_id: customer.id)
    item_2 = merchant_2.items.create(name: 'Item 2', description: "I'm another item!", unit_price: 100)
    invoice_2.invoice_items.create(item_id: item_2.id, quantity: 10, unit_price: 100)
    invoice_2.transactions.create(credit_card_number: '1234567887654321', result: 'success')

    merchant_3 = create(:merchant, name: 'Merchant 3')
    invoice_3 = Invoice.create(status: 'shipped', merchant_id: merchant_3.id, customer_id: customer.id)
    item_3 = merchant_3.items.create(name: 'Item 3', description: "I'm a different item!", unit_price: 100)
    invoice_3.invoice_items.create(item_id: item_3.id, quantity: 40, unit_price: 100)
    invoice_3.transactions.create(credit_card_number: '1234567887654321', result: 'success')

    get '/api/v1/merchants/most_revenue?quantity=3'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']
    require "pry"; binding.pry

    expect(merchants[0]['attributes']['id']).to eq(merchant_3.id)
    expect(merchants[1]['attributes']['id']).to eq(merchant_1.id)
    expect(merchants[2]['attributes']['id']).to eq(merchant_2.id)
  end
end
