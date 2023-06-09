class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_owner, only: [:edit, :update]
  before_action :redirect_if_sold_out, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def index
    @items = Item.order('created_at DESC')
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user.id
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id,
                                 :shipping_date_id, :image, :user_id)
  end

  def redirect_if_not_owner
    return if current_user == @item.user

    redirect_to root_path
  end

  def redirect_if_sold_out
    @item = Item.find(params[:id])
    return unless @item.purchase.present?

    redirect_to root_path, alert: 'This item has already been sold out.'
  end
end
