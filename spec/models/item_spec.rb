require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user) # ユーザーを作成して関連付ける
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品出品' do
    context '商品が出品できるとき' do
      it '全ての項目が正しく入力されていれば、出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it '画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank") # 修正
      end

      it 'カテゴリーが空では出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が空では出品できない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank") # 修正
      end

      it '配送料の負担が空では出品できない' do
        @item.shipping_cost_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank") # 修正
      end

      it '発送元の地域が空では出品できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が空では出品できない' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank") # 修正
      end

      it '価格が空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が¥300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が¥10,000,000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格が半角数値でない場合、出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '価格が英字のみでは出品できない' do
        @item.price = 'abcd'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '価格が英字と数字の混合では出品できない' do
        @item.price = 'abc123'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end