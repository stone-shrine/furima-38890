require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user1.id)
    @order_address = FactoryBot.build(:order_address, user_id: user2.id, item_id: item.id)
    sleep 0.1 # Mysql2::Error: MySQL client is not connected のエラーが発生したため待機時間を設定
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it 'すべての内容が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'zip_codeが空だと購入できない' do
        @order_address.zip_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Zip code can't be blank")
      end

      it 'cityが空だと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'streetが空だと購入できない' do
        @order_address.street = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street can't be blank")
      end

      it 'phoneが空だと購入できない' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end

      it 'tokenが空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'zip_codeに-（ハイフォン）がないと購入できない' do
        @order_address.zip_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeにー（伸ばし棒）を含むと購入できない' do
        @order_address.zip_code = '123ー4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに-（ハイフォン）の前に数字が2桁以下だと購入できない' do
        @order_address.zip_code = '12-1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに-（ハイフォン）の前に数字が4桁以上だと購入できない' do
        @order_address.zip_code = '1234-1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに-（ハイフォン）の後に数字が3桁以下だと購入できない' do
        @order_address.zip_code = '123-123'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに-（ハイフォン）の後に数字が5桁以上だと購入できない' do
        @order_address.zip_code = '123-12345'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに全角数字を含むと購入できない' do
        @order_address.zip_code = '123-123４'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに英字を含むと購入できない' do
        @order_address.zip_code = '123-1234a'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに漢字を含むと購入できない' do
        @order_address.zip_code = '123-1234亜'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに平仮名を含むと購入できない' do
        @order_address.zip_code = '123-1234あ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'zip_codeに片仮名を含むと購入できない' do
        @order_address.zip_code = '123-1234ア'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code is invalid. Include hyphen(-)')
      end

      it 'prefectureが1だと購入できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'phoneに数字が9桁以下だと購入できない' do
        @order_address.phone = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is too short')
      end

      it 'phoneに数字が12桁以上と購入できない' do
        @order_address.phone = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is too short')
      end

      it 'phoneに-（ハイフォン）を含むと購入できない' do
        @order_address.phone = '123-1234-1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end

      it 'phoneにー（伸ばし棒）を含むと購入できない' do
        @order_address.phone = '123ー1234ー1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end

      it 'phoneに全角数字を含むと購入できない' do
        @order_address.phone = '1231234123４'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end

      it 'phoneに英字を含むと購入できない' do
        @order_address.phone = '12312341234a'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end

      it 'phoneに漢字を含むと購入できない' do
        @order_address.phone = '123-1234-1234亜'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end

      it 'phoneに平仮名を含むと購入できない' do
        @order_address.phone = '123-1234-1234あ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end

      it 'phoneに片仮名を含むと購入できない' do
        @order_address.phone = '123-1234-1234ア'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end

      it 'userが紐付いていないと購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
