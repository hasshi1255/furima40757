class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネームが必須であること
  validates :nickname, presence: true

  # パスワードが必須であること、6文字以上であること、半角英数字混合であること
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }

  # お名前(全角)が必須であること、全角（漢字・ひらがな・カタカナ）での入力が必須であること
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }

  # お名前カナ(全角)が必須であること、全角（カタカナ）での入力が必須であること
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }

  # 生年月日が必須であること
  validates :birth_date, presence: true

  has_many :items
  has_many :purchases
end
