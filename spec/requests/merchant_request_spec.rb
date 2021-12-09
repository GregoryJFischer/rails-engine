require 'rails_helper'

describe 'Merchant Requests' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    merchants = data[:data]

    expect(merchants).to be_a Array
    expect(merchants.length).to eq 5

    merchants.each do |merchant|
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  it 'can get a specific merchant' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:attributes][:name]).to eq merchant.name
  end

  it 'can find a specific merchant by name' do
    merchant_1 = create(:merchant, name: "ba")
    merchant_2 = create(:merchant, name: "ab")
    merchant_3 = create(:merchant, name: "c")

    get '/api/v1/merchants/find?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:attributes][:name]).to eq merchant_2.name
  end

  it 'retuns an empty has when no merchant is found' do
    get '/api/v1/merchants/find?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data]).to eq({})
  end

  it 'can find all merchants by name' do
    merchant_1 = create(:merchant, name: "ba")
    merchant_2 = create(:merchant, name: "ab")
    merchant_3 = create(:merchant, name: "c")

    get '/api/v1/merchants/find_all?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    names = data[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(names).to eq [merchant_2.name, merchant_1.name]
  end

  it 'returns an empty array if no names match' do
    get '/api/v1/merchants/find_all?name=b'

    expect(response.status).to eq 200

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data]).to eq []
  end
end