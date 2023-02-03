require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end


  describe "商品出品機能" do
    context "商品の出品ができる場合" do
      it "記入欄が全て正しく記入されていれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context "商品の出品ができない場合" do
      it "imageが空だとと出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空だと出品できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "descriptionが空だと出品できない" do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "category_idの値が1だと出品できない" do
        @item.category = Category.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "status_idの値が1だと出品できない" do
        @item.status = Status.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it "payment_idの値が1だと出品できない" do
        @item.payment = Payment.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("Payment can't be blank")
      end
      it "prefecture_idの値が1だと出品できない" do
        @item.prefecture = Prefecture.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "lead_time_idの値が1だと出品できない" do
        @item.lead_time = LeadTime.where(id: 1).sample
        @item.valid?
        expect(@item.errors.full_messages).to include("Lead time can't be blank")
      end
      it "priceが空だと出品できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが299以下だと出品できない" do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it "priceが10,000,000以上だと出品できない" do
        @item.price = '10_000_000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it "priceが全角数字を含んでいると出品できない" do
        @item.price = '1000０'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it "priceが漢字を含んでいると出品できない" do
        @item.price = '1000亜'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it "priceが平仮名を含んでいると出品できない" do
        @item.price = '1000あ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it "priceが片仮名を含んでいると出品できない" do
        @item.price = '1000ア'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it "priceが英字を含んでいると出品できない" do
        @item.price = '1000a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it "userが紐付いていないと出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end