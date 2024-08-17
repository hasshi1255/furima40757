class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image

  # 商品名が必須であること
  validates :name, presence: true

  # 商品の説明が必須であること
  validates :description, presence: true

  # カテゴリーの情報が必須であること
  validates :category_id, presence: true

  # 商品の状態の情報が必須であること
  validates :condition_id, presence: true

  # 配送料の負担の情報が必須であること
  validates :shipping_cost_id, presence: true

  # 発送元の地域の情報が必須であること
  validates :prefecture_id, presence: true

  # 発送までの日数の情報が必須であること
  validates :shipping_day_id, presence: true

  # 価格が必須であること、かつ価格が¥300~¥9,999,999の範囲内であること
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # 商品画像が必須であること
  validates :image, presence: true
end
