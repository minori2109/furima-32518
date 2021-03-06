require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品ができるとき' do
      it 'image、name、detail、category_id、status_id、shipping_fee_id、shipping_area_id、shipping_date_id、priceが存在すれば保存できること' do
        expect(@item).to be_valid
      end
      it '販売価格が半角数字で入力された場合、保存できること' do
        @item.price = 2500
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができないとき' do
      it 'imageが空では保存できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors[:image]).to include("を入力してください")
      end
      it 'nameが空では保存できないこと' do
        @item.name = nil
        @item.valid?
        expect(@item.errors[:name]).to include("を入力してください")
      end
      it 'detailが空では保存できないこと' do
        @item.detail = nil
        @item.valid?
        expect(@item.errors[:detail]).to include("を入力してください")
      end
      it 'category_idが「1」の場合、保存できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors[:category_id]).to include('を選択してください')
      end
      it 'status_idが「1」の場合、保存できないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors[:status_id]).to include('を選択してください')
      end
      it 'shipping_fee_idが「1」の場合、保存できないこと' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors[:shipping_fee_id]).to include('を選択してください')
      end
      it 'shipping_area_idが「1」の場合、保存できないこと' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors[:shipping_area_id]).to include('を選択してください')
      end
      it 'shipping_date_idが「1」の場合、保存できないこと' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors[:shipping_date_id]).to include('を選択してください')
      end
      it 'priceが空では保存できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors[:price]).to include("を入力してください")
      end
      it 'priceが半角英数混合では保存できないこと' do
        @item.price = 'abc123'
        @item.valid?
        expect(@item.errors[:price]).to include("は半角数字で入力してください", "は300~9,999,999円の範囲で入力してください")
      end
      it 'priceが半角英字だけでは保存できないこと' do
        @item.price = 'abcdef'
        @item.valid?
        expect(@item.errors[:price]).to include("は半角数字で入力してください", "は300~9,999,999円の範囲で入力してください")
      end
      it 'priceが全角で入力された場合、保存できないこと' do
        @item.price = '４５００'
        @item.valid?
        expect(@item.errors[:price]).to include("は半角数字で入力してください", "は300~9,999,999円の範囲で入力してください")
      end
      it 'priceの値が300円より低いとき保存できないこと' do
        @item.price = 200
        @item.valid?
        expect(@item.errors[:price]).to include("は300~9,999,999円の範囲で入力してください")
      end
      it 'priceの値が9,999,999円より高いとき保存できないこと' do
        @item.price = 99_999_999
        @item.valid?
        expect(@item.errors[:price]).to include("は300~9,999,999円の範囲で入力してください")
      end
      it 'userが紐づいていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors[:user]).to include('must exist')
      end
    end
  end
end
