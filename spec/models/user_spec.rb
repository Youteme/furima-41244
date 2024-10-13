require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '内容に問題ない場合' do
      it '全て正常' do
        expect(@user.valid?).to eq true
      end
    end
    context '内容に問題がある場合' do
      it 'ニックネームが必須であること。' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること。' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること。' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは@を含む必要があること。' do
        @user.email = 'abc.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること。' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは6文字以上であること。' do
        @user.password = '11111a'
        @user.password_confirmation = '11111a'
        expect(@user).to be_valid
      end
      it 'パスワードは半角英数字混合であること。' do
        @user.password ='test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)は、名字と名前がそれぞれ必須であること。' do
        user = FactoryBot.build(:user, last_name: 'ｱｲｳｴｵ', first_name: 'ｱｲｳｴｵ')
        user.valid?
        expect(user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
        expect(user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end

      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.last_name = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end

      it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること。' do
        user = FactoryBot.build(:user, last_name_kana: 'ｱｲｳｴｵ', first_name_kana: nil)
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
        expect(user.errors.full_messages).to include("First name kana can't be blank") # 名前カナが空のエラーメッセージも確認
      end

      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
        @user.last_name_kana = 'ｱｲｳｴｵ' 
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
      end

      it '生年月日が必須であること' do 
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end