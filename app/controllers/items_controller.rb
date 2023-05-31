class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update]
  before_action :redirect_if_not_owner, only: [:edit, :update]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
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
end
