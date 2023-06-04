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
      Payjp.api_key = "sk_test_0cc100df8cd68b2a163e87f7"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      charge = Payjp::Charge.create(
        amount: @item.price,            # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      if charge.present?
        ActiveRecord::Base.transaction do
        @purchase_shipment.save # フォームオブジェクトのsaveメソッドを実行

        end
        redirect_to root_path # トップページにリダイレクト
      else
        render :index # indexアクションのviewを表示
      end
    else
      render :index # indexアクションのviewを表示
    end
  end


  private

  def purchase_params
    params.require(:purchase_shipment).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id,).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:card_token])
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.purchase.present?
      redirect_to root_path
    end
  end  

end
