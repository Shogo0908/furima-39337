class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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

  # def show
  #   @item = Item.find(params[:id])
  # end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id,
                                 :shipping_date_id, :image, :user_id)
  end
end
