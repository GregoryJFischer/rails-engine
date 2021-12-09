require 'rails_helper'

describe Item do
  describe 'class methods' do
    describe '.find_one' do
      it 'returns one item by searching by name' do
        item_1 = create(:item, name: "ba")
        item_2 = create(:item, name: "ab")
        item_3 = create(:item, name: "c")

        expect(Item.find_one("b")).to eq item_2
      end
    end

    describe '.find_all' do
      it 'returns all items by searching by name' do
        item_1 = create(:item, name: "ba")
        item_2 = create(:item, name: "ab")
        item_3 = create(:item, name: "c")

        expect(Item.find_all("b")).to eq [item_2, item_1]
      end
    end
  end
end