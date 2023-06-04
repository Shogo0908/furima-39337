require 'rails_helper'

RSpec.describe PurchaseShipment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: @user.id)
    @item.image.attach(io: File.open('./test_image.png'), filename: 'test_image.png')
    @purchase_shipment = FactoryBot.build(:purchase_shipment, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipment).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase_shipment.building_name = nil
        expect(@purchase_shipment).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it '郵便番号が必須であること' do
        @purchase_shipment.postal_code = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にはハイフンが必要であること' do
        @purchase_shipment.postal_code = '1234567'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Postal code is invalid')
      end

      it '郵便番号が全角数字だと保存できないこと' do
        @purchase_shipment.postal_code = '１２３'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Postal code is invalid')
      end

      it '都道府県を選択していないと保存できないこと' do
        @purchase_shipment.prefecture_id = '0'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では保存できないこと' do
        @purchase_shipment.city = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できないこと' do
        @purchase_shipment.address = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では保存できないこと' do
        @purchase_shipment.phone_number = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が12桁以上では保存できないこと' do
        @purchase_shipment.phone_number = '09012345678901'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が9桁以下では保存できないこと' do
        @purchase_shipment.phone_number = '0901234'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが空では登録できないこと' do
        @purchase_shipment.token = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では購入できないこと' do
        @purchase_shipment.user_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("User can't be blank")
      end
      
      it 'item_idが空では購入できないこと' do
        @purchase_shipment.item_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
