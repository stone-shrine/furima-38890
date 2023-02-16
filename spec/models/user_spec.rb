require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '記入欄が全て正しく記入されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)を入力してください")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)を入力してください")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)を入力してください")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)を入力してください")
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        user2 = FactoryBot.build(:user, email: @user.email)
        user2.valid?
        expect(user2.errors.full_messages).to include('メールアドレスはすでに存在します')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'as123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'asd123'
        @user.password_confirmation = 'asd234'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordが英字だけでは登録できない' do
        @user.password = 'qweasd'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordが数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordに漢字が含まれていると登録できない' do
        @user.password = '123qwe亜'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordに平仮名が含まれていると登録できない' do
        @user.password = '123qweあ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordに片仮名が含まれていると登録できない' do
        @user.password = '123qweア'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordに記号が含まれていると登録できない' do
        @user.password = '123qwe!'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'last_nameに英字が含まれていると登録できない' do
        @user.last_name = '織田a'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)は不正な値です')
      end

      it 'last_nameに数字が含まれていると登録できない' do
        @user.last_name = '織田1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)は不正な値です')
      end

      it 'last_nameに記号が含まれていると登録できない' do
        @user.last_name = '織田_'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)は不正な値です')
      end

      it 'first_nameに英字が含まれていると登録できない' do
        @user.first_name = '信長a'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)は不正な値です')
      end

      it 'first_nameに数字が含まれていると登録できない' do
        @user.first_name = '信長1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)は不正な値です')
      end

      it 'first_nameに記号が含まれていると登録できない' do
        @user.first_name = '信長_'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)は不正な値です')
      end

      it 'last_name_kanaに漢字が含まれていると登録できない' do
        @user.last_name_kana = 'オダ亜'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓)は不正な値です')
      end

      it 'last_name_kanaに平仮名が含まれていると登録できない' do
        @user.last_name_kana = 'オダあ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓)は不正な値です')
      end

      it 'last_name_kanaに英字が含まれていると登録できない' do
        @user.last_name_kana = 'オダa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓)は不正な値です')
      end

      it 'last_name_kanaに数字が含まれていると登録できない' do
        @user.last_name_kana = 'オダ1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓)は不正な値です')
      end

      it 'last_name_kanaに記号が含まれていると登録できない' do
        @user.last_name_kana = 'オダ_'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓)は不正な値です')
      end

      it 'first_name_kanaに漢字が含まれていると登録できない' do
        @user.first_name_kana = 'ノブナガ亜'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名)は不正な値です')
      end

      it 'first_name_kanaに平仮名が含まれていると登録できない' do
        @user.first_name_kana = 'ノブナガあ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名)は不正な値です')
      end

      it 'first_name_kanaに英字が含まれていると登録できない' do
        @user.first_name_kana = 'ノブナガa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名)は不正な値です')
      end

      it 'first_name_kanaに数字が含まれていると登録できない' do
        @user.first_name_kana = 'ノブナガ1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名)は不正な値です')
      end

      it 'first_name_kanaに記号が含まれていると登録できない' do
        @user.first_name_kana = 'ノブナガ_'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名)は不正な値です')
      end
    end
  end
end
