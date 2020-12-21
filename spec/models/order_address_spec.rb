require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '商品購入機能' do
    context '商品の購入ができるとき' do
      it 'postcode,shipping_area_id,city,block,building,phone_number,tokenの値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end

      it 'buidingは空でも保存できること' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end

    context '商品の購入ができないとき' do
      it 'postcodeが空だと保存できないこと' do
        @order_address.postcode = nil
        @order_address.valid?
        expect(@order_address.errors[:postcode]).to include("を入力してください")
      end

      it 'postcodeが全角だと保存できないこと' do
        @order_address.postcode = '１２３ー４５６７'
        @order_address.valid?
        expect(@order_address.errors[:postcode]).to include('はハイフンを含む半角数字7桁で入力してください')
      end

      it 'postcodeが半角英字だと保存できないこと' do
        @order_address.postcode = 'abcdefg'
        @order_address.valid?
        expect(@order_address.errors[:postcode]).to include('はハイフンを含む半角数字7桁で入力してください')
      end

      it 'postcodeがハイフンを含む正しい形式でないと保存できないこと' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors[:postcode]).to include('はハイフンを含む半角数字7桁で入力してください')
      end

      it 'shipping_area_idが選択されていないと保存できないこと' do
        @order_address.shipping_area_id = 1
        @order_address.valid?
        expect(@order_address.errors[:shipping_area_id]).to include('を選択してください')
      end

      it 'cityが空だと保存できないこと' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors[:city]).to include("を入力してください")
      end

      it 'blockが空だと保存できないこと' do
        @order_address.block = nil
        @order_address.valid?
        expect(@order_address.errors[:block]).to include("を入力してください")
      end

      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include("を入力してください")
      end

      it 'phone_numberが全角だと保存できないこと' do
        @order_address.phone_number = '０８０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('は半角数字で入力してください')
      end

      it 'phone_numberが半角英字だと保存できないこと' do
        @order_address.phone_number = 'abcdefghijkl'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('は半角数字で入力してください')
      end

      it 'phone_numberにハイフンが含まれていると保存できないこと' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('は半角数字で入力してください')
      end

      it 'phone_numberは ハイフンを含まない11桁でないと保存できないこと' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it 'user_idが存在しない場合は保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors[:user_id]).to include("を入力してください")
      end

      it 'item_idが存在しない場合は保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors[:item_id]).to include("を入力してください")
      end

      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors[:token]).to include("を入力してください")
      end
    end
  end
end
