class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_item_sold_out_or_owned, only: [:index]

  def index
    @purchase = Purchase.new
    @shipping_address = ShippingAddress.new
    @item = Item.find(params[:item_id])

    render 'orders/index'
  end

  def create
    @purchase = Purchase.new(user: current_user, item: @item)

    if @purchase.valid?
      pay_item
      @shipping_address = @purchase.build_shipping_address(order_params)

      if @shipping_address.save
        redirect_to root_path, notice: '購入が完了しました。'
      else
        render :index, status: :unprocessable_entity
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_item_sold_out_or_owned
    return unless @item.sold_out? || @item.user == current_user

    redirect_to root_path
  end

  def order_params
    params.require(:purchase).permit(:postal_code, :prefecture_id, :city, :address, :building_name,
                                     :phone_number).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = 'sk_test_5189c670933163d318dc124d' # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
