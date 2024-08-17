class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # ActiveHashとのアソシエーション
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day

  # その他のアソシエーション
  belongs_to :user
  has_one_attached :image

  # 商品名が必須であること
  validates :name, presence: true

  # 商品の説明が必須であること
  validates :description, presence: true

  # ActiveHashの項目に関するバリデーション
  # "1"は「---」に対応するID値を想定しています
  validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id,
            numericality: { greater_than: 1, message: 'を選択してください' }

  # 価格が必須であること、かつ価格が¥300~¥9,999,999の範囲内であること、半角数値のみを許可する
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # 商品画像が必須であること
  validates :image, presence: true
end
