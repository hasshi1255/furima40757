require 'rails_helper'

require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase = FactoryBot.build(:purchase_shipping, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品が購入できるとき' do
      it '必要な情報を適切に入力して購入ボタンを押すと、商品の購入ができること' do
        expect(@purchase).to be_valid
      end

      it '建物名が空でも購入できること' do
        @purchase.building_name = nil
        expect(@purchase).to be_valid
      end
    end

    context '商品が購入できないとき' do
      it 'tokenが空では登録できないこと' do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が必須であること' do
        @purchase.postal_code = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能であること' do
        @purchase.postal_code = '1234567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Postal code is invalid')
      end

      it '都道府県が必須であること' do
        @purchase.prefecture_id = 1
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it '市区町村が必須であること' do
        @purchase.city = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須であること' do
        @purchase.address = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が必須であること' do
        @purchase.phone_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は10桁以上11桁以内の半角数値のみ保存可能であること' do
        @purchase.phone_number = '090-1234-5678'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が9桁以下では保存できないこと' do
        @purchase.phone_number = '090123456'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end
      
      it '電話番号が12桁以上では保存できないこと' do
        @purchase.phone_number = '090123456789'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end
      
      it '電話番号は半角数値以外では保存できないこと' do
        @purchase.phone_number = '090-1234-5678'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end

      it 'userが紐づいていないと購入できないこと' do
        @purchase.user_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていないと購入できないこと' do
        @purchase.item_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが紐づいていないと購入できないこと' do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end