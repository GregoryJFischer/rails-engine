require 'rails_helper'

describe 'Item Requests' do
  it 'can get all of the items' do
    create_list(:item, 5)

    get '/api/v1/items'

    expect(response.status).to eq 200

    body = JSON.parse(response.body, symbolize_names: true)
    data = body[:data]

    expect(data.length).to eq 5

    data.each do |item|
      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes][:unit_price]).to be_a Float
      expect(item[:attributes][:description]).to be_a String
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end
  end

  it 'can get a specific item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response.status).to eq 200

    body = JSON.parse(response.body, symbolize_names: true)
    data = body[:data]

    expect(data[:attributes].count).to eq 4
    expect(data[:attributes][:name]).to eq item.name
    expect(data[:attributes][:unit_price]).to eq item.unit_price
    expect(data[:attributes][:description]).to eq item.description
    expect(data[:attributes][:merchant_id]).to eq item.merchant_id
  end

  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = {name: 'test', unit_price: 1, description: ' ', merchant_id: merchant.id}

    post "/api/v1/items", params: item_params

    expect(response.status).to eq 201

    item = Item.last

    expect(item.name).to eq 'test'
    expect(item.unit_price).to eq 1
    expect(item.description).to eq ' '
    expect(item.merchant_id).to eq merchant.id
  end

  it 'can update an item' do
    item = create(:item, name: 'test')

    put "/api/v1/items/#{item.id}", params: {name: 'tset'}

    expect(Item.last.name).to eq 'tset'
  end

  it 'returns an error if the item is not found' do
    put '/api/v1/items/999999999999', params: {name: 'test'}

    expect(response.status).to eq 404

    expect(response.body).to match(/Couldn't find Item with/)
  end

  it 'returns an error if the item cannot be updated' do
    item = create(:item, name: 'test')

    put "/api/v1/items/#{item.id}", params: {merchant_id: 1.5}

    expect(response.status).to eq 400

    expect(response.body).to match(/couldn't update item/)
  end

  it 'can delete an item' do
    item = create(:item)

    delete "/api/v1/items/#{item.id}"

    expect(response.status).to eq 204
  end

  it 'can find an item by a name fragment' do
    item_1 = create(:item, name: "ba")
    item_2 = create(:item, name: "ab")
    item_3 = create(:item, name: "c")

    get '/api/v1/items/find?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:attributes][:name]).to eq item_2.name
  end

  it 'retuns an empty has when no item is found' do
    get '/api/v1/items/find?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data]).to eq({})
  end

  it 'can find all items by name' do
    item_1 = create(:item, name: "ba")
    item_2 = create(:item, name: "ab")
    item_3 = create(:item, name: "c")

    get '/api/v1/items/find_all?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    names = data[:data].map do |item|
      item[:attributes][:name]
    end

    expect(names).to eq [item_2.name, item_1.name]
  end

  it 'returns an empty array if no names match' do
    get '/api/v1/items/find_all?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data]).to eq []
  end
end