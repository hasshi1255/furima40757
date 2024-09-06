class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_item_sold_out_or_owned, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @purchase = Purchase.new

    render 'orders/index'
  end

  def create
    @purchase = Purchase.new(order_params)
    @purchase.item = @item

    if @purchase.save
      redirect_to root_path
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
    params.require(:purchase).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number)
  end
end
