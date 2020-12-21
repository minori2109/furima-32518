require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の英数混合であれば登録できる' do
        @user.password = 'TeSt123'
        @user.password_confirmation = 'TeSt123'
        expect(@user).to be_valid
      end
      it 'ユーザー本名が全角で入力されていれば登録できる' do
        @user.last_name = '田中'
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナが全角で入力されていれば登録できる' do
        @user.last_name = 'タナカ'
        @user.first_name = 'タロウ'
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors[:nickname]).to include("を入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors[:email]).to include('has already been taken')
      end
      it 'emailに@がない場合登録できない' do
        @user.email = 'testmail.com'
        @user.valid?
        expect(@user.errors[:email]).to include('is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank", "パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'pass1'
        @user.valid?
        expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors[:password]).to include('パスワードには英字と数字の両方を含めて設定してください')
      end
      it 'passwordが半角英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors[:password]).to include('パスワードには英字と数字の両方を含めて設定してください')
      end
      it 'passwordが全角英数混合では登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors[:password]).to include('パスワードには英字と数字の両方を含めて設定してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end
      it 'ユーザー本名の名字が空だと登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors[:last_name]).to include("を入力してください")
      end
      it 'ユーザー本名の名前が空だと登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors[:first_name]).to include("を入力してください")
      end
      it 'ユーザー本名の名字が半角では登録できない' do
        @user.last_name = 'ﾀﾅｶ'
        @user.valid?
        expect(@user.errors[:last_name]).to include('は全角で入力してください')
      end
      it 'ユーザー本名の名前が半角では登録できない' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors[:first_name]).to include('は全角で入力してください')
      end
      it 'ユーザー本名のフリガナの名字が空だと登録できない' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("を入力してください")
      end
      it 'ユーザー本名のフリガナの名前が空だと登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("を入力してください")
      end
      it 'ユーザー本名のフリガナの名字が半角では登録できない' do
        @user.last_name_kana = 'ｲﾄｳ'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include('は全角カタカナで入力してください')
      end
      it 'ユーザー本名のフリガナの名字が半角では登録できない' do
        @user.first_name_kana = 'ｼﾞｭﾝ'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
      end
      it 'ユーザー本名のフリガナの名字が全角ひらがなでは登録できない' do
        @user.last_name_kana = 'さとう'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include('は全角カタカナで入力してください')
      end
      it 'ユーザー本名のフリガナの名前が全角ひらがなでは登録できない' do
        @user.first_name_kana = 'しずか'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors[:birthday]).to include("を入力してください")
      end
    end
  end
end
