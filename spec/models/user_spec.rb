require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての必須項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        expect(@user).to_not be_valid
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        expect(@user).to_not be_valid
      end

      it '重複したメールアドレスが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        expect(another_user).to_not be_valid
      end

      it 'メールアドレスに@が含まれていない場合登録できない' do
        @user.email = 'testemail.com'
        expect(@user).to_not be_valid
      end

      it 'パスワードが空では登録できない' do
        @user.password = ''
        expect(@user).to_not be_valid
      end

      it 'パスワードが6文字未満では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        expect(@user).to_not be_valid
      end

      it 'パスワードが半角英数字混合でなければ登録できない' do
        @user.password = 'abcdef'
        expect(@user).to_not be_valid
      end

      it 'パスワードとパスワード（確認）が一致していなければ登録できない' do
        @user.password_confirmation = 'different'
        expect(@user).to_not be_valid
      end

      it '名字が空では登録できない' do
        @user.last_name = ''
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end

      it '名前が空では登録できない' do
        @user.first_name = ''
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it '名字が全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.last_name = 'abc'
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("名字全角文字を使用してください")
      end

      it '名前が全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name = 'abc'
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("名前全角文字を使用してください")
      end

      it '名字カナが空では登録できない' do
        @user.last_name_kana = ''
        expect(@user).to_not be_valid
      end

      it '名前カナが空では登録できない' do
        @user.first_name_kana = ''
        expect(@user).to_not be_valid
      end

      it '名字カナが全角カタカナでなければ登録できない' do
        @user.last_name_kana = 'あいうえお'
        expect(@user).to_not be_valid
      end

      it '名前カナが全角カタカナでなければ登録できない' do
        @user.first_name_kana = 'あいうえお'
        expect(@user).to_not be_valid
      end

      it '生年月日が空では登録できない' do
        @user.birth_date = ''
        expect(@user).to_not be_valid
      end
    end
  end
end