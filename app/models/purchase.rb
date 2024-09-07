class Purchase < ApplicationRecord
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number

  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  # トークンのバリデーション
  validates :token, presence: true

  # 郵便番号のバリデーション
  validates :postal_code, presence: { message: "can't be blank" },
                          format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }

  # 都道府県のバリデーション
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  # 市区町村のバリデーション
  validates :city, presence: { message: "can't be blank" }

  # 番地のバリデーション
  validates :address, presence: { message: "can't be blank" }

  # 電話番号のバリデーション
  validates :phone_number, presence: { message: "can't be blank" },
                           format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                           length: { minimum: 10, message: 'is too short' }

  # Purchaseオブジェクト保存時にShippingAddressの情報も保存する
  def save
    purchase = Purchase.create(user_id:, item_id:)
    ShippingAddress.create(postal_code:, prefecture_id:, city:, address:,
                           building_name:, phone_number:, purchase_id: purchase.id)
  end
end
