require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_address).to be_valid
    end

    it 'postcodeが空だと保存できないこと' do
      @order_address.postcode = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
    end

    it 'postcodeが全角だと保存できないこと' do
      @order_address.postcode = '１２３ー４５６７'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postcode Input correctly')
    end

    it 'postcodeにハイフンを含む正しい形式でないと保存できないこと' do
      @order_address.postcode = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postcode Input correctly')
    end

    it 'shipping_area_idが選択されていないと保存できないこと' do
      @order_address.shipping_area_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Shipping area Select')
    end

    it 'cityが空だと保存できないこと' do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'blockが空だと保存できないこと' do
      @order_address.block = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Block can't be blank")
    end

    it 'buidingは空でも保存できること' do
      @order_address.building = nil
      expect(@order_address).to be_valid
    end

    it 'phone_numberが空だと保存できないこと' do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが全角だと保存できないこと' do
      @order_address.phone_number = '０８０１２３４５６７８'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number Input only number')
    end

    it 'phone_numberにハイフンが含まれていると保存できないこと' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number Input only number')
    end

    it 'phone_numberは ハイフンを含まない11桁でないと保存できないこと' do
      @order_address.phone_number = '090-12345-6789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number Input only number')
    end

    it 'tokenが空では登録できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end
