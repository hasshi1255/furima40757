class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id

  # バリデーション
  validates :token, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }

  def save
      purchase = Purchase.create!(user_id: user_id, item_id: item_id)
      shipping_address = ShippingAddress.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number,
        purchase_id: purchase.id
      )
  end
end