class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネームが必須であること
  validates :nickname, presence: true

  # メールアドレスが必須であること、一意性であること、@を含む形式であること
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  # パスワードが必須であること、6文字以上であること、半角英数字混合であること
  validates :password, presence: true, length: { minimum: 6 },
                       format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: '文字と数字の両方を含める必要があります' }

  # パスワードとパスワード（確認）が一致していること
  validates :password_confirmation, presence: true, on: :create

  # お名前(全角)が必須であること、全角（漢字・ひらがな・カタカナ）での入力が必須であること
  validates :last_name, :first_name, presence: true,
                                     format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字である必要があります' }

  # お名前カナ(全角)が必須であること、全角（カタカナ）での入力が必須であること
  validates :last_name_kana, :first_name_kana, presence: true,
                                               format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナである必要があります' }

  # 生年月日が必須であること
  validates :birth_date, presence: true
end
