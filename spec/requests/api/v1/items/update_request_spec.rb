require 'rails_helper'

RSpec.describe 'Items API' do
  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name

    patch "/api/v1/items/#{id}", params: {name: "Sledge"}
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Sledge")
  end
end
