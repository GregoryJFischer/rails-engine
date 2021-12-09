require 'rails_helper'

describe Merchant do
  describe 'class methods' do
    describe '.find_one' do
      it 'returns one merchant by searching by name' do
        merchant_1 = create(:merchant, name: "ba")
        merchant_2 = create(:merchant, name: "ab")
        merchant_3 = create(:merchant, name: "c")

        expect(Merchant.find_one("b")).to eq merchant_2
      end
    end

    describe '.find_all' do
      it 'returns all merchants by searching by name' do
        merchant_1 = create(:merchant, name: "ba")
        merchant_2 = create(:merchant, name: "ab")
        merchant_3 = create(:merchant, name: "c")

        expect(Merchant.find_all("b")).to eq [merchant_2, merchant_1]
      end
    end
  end
end