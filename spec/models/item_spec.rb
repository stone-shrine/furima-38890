require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品ができる場合' do
      it '記入欄が全て正しく記入されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができない場合' do
      it 'imageが空だとと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end

      it 'nameが空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'descriptionが空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'category_idの値が1だと出品できない' do
        @item.category = Category.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it 'status_idの値が1だと出品できない' do
        @item.status = Status.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it 'payment_idの値が1だと出品できない' do
        @item.payment = Payment.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it 'prefecture_idの値が1だと出品できない' do
        @item.prefecture = Prefecture.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it 'lead_time_idの値が1だと出品できない' do
        @item.lead_time = LeadTime.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it 'priceが299以下だと出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が不正な値です')
      end

      it 'priceが10,000,000以上だと出品できない' do
        @item.price = '10_000_000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が不正な値です')
      end

      it 'priceが全角数字を含んでいると出品できない' do
        @item.price = '1000０'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角英数字で入力してください')
      end

      it 'priceが漢字を含んでいると出品できない' do
        @item.price = '1000亜'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角英数字で入力してください')
      end

      it 'priceが平仮名を含んでいると出品できない' do
        @item.price = '1000あ'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角英数字で入力してください')
      end

      it 'priceが片仮名を含んでいると出品できない' do
        @item.price = '1000ア'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角英数字で入力してください')
      end

      it 'priceが英字を含んでいると出品できない' do
        @item.price = '1000a'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角英数字で入力してください')
      end

      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('ユーザーを入力してください')
      end
    end
  end
end
