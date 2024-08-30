class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_item_owner, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def check_item_owner
    redirect_to root_path unless @item.user_id == current_user.id
  end

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :description,
      :category_id,
      :condition_id,
      :shipping_cost_id,
      :prefecture_id,
      :shipping_day_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
