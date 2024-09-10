require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  let(:valid_attributes) do
    {
      token: 'tok_abc123',
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '東京都',
      address: '1-1',
      building_name: 'マンション101',
      phone_number: '09012345678',
      user_id: 1,
      item_id: 1
    }
  end

  describe 'バリデーション' do
    it 'すべての属性が正しく設定されていると有効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes)
      expect(purchase_shipping).to be_valid
    end

    it 'tokenが空の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(token: ''))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:token]).to include("can't be blank")
    end

    it 'postal_codeが空の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(postal_code: ''))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:postal_code]).to include("can't be blank")
    end

    it 'postal_codeが不正な形式の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(postal_code: '1234567'))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:postal_code]).to include('is invalid')
    end

    it 'prefecture_idが1の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(prefecture_id: 1))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:prefecture_id]).to include('must be other than 1')
    end

    it 'cityが空の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(city: ''))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:city]).to include("can't be blank")
    end

    it 'addressが空の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(address: ''))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:address]).to include("can't be blank")
    end

    it 'phone_numberが空の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(phone_number: ''))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:phone_number]).to include("can't be blank")
    end

    it 'phone_numberが不正な形式の場合無効であること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(phone_number: '123456'))
      expect(purchase_shipping).to be_invalid
      expect(purchase_shipping.errors[:phone_number]).to include('is invalid')
    end
  end

  describe '#save' do
    it '購入と配送先情報が正しく保存されること' do
      purchase_shipping = PurchaseShipping.new(valid_attributes)
      expect { purchase_shipping.save }.to change { Purchase.count }.by(1).and change { ShippingAddress.count }.by(1)
    end

    it 'エラーが発生した場合は購入と配送先情報が保存されないこと' do
      purchase_shipping = PurchaseShipping.new(valid_attributes.merge(postal_code: '1234567'))
      expect { purchase_shipping.save }.not_to change { Purchase.count }
      expect { purchase_shipping.save }.not_to change { ShippingAddress.count }
    end
  end
end

