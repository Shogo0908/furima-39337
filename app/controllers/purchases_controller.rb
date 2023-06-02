class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create] # ログインしていなければログインページへ
  before_action :move_to_root, only: [:index, :create] # 商品の出品者または売却済み商品の場合、トップページへ

  def index
    @item = Item.find(params[:item_id])  # 購入する商品を特定
    @purchase_shipment = PurchaseShipment.new # フォームオブジェクトのインスタンスを生成
  end

  def create
    @item = Item.find(params[:item_id])  # 購入する商品を特定
    @purchase_shipment = PurchaseShipment.new(purchase_params) # フォームオブジェクトのインスタンスを生成
    if @purchase_shipment.valid? # バリデーションを実行
      pay_item # payjpのメソッドを実行
      @purchase_shipment.save # フォームオブジェクトのsaveメソッドを実行
      redirect_to root_path # トップページにリダイレクト
    else
      render :index # indexアクションのviewを表示
    end
  end


  private

  def purchase_params
    params.require(:purchase_shipment).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id).merge(user_id: current_user.id, token: params[:token])
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.purchase.present?
      redirect_to root_path
    end
  end  

end
