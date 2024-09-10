class Purchase < ApplicationRecord
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number

  belongs_to :user
  belongs_to :item
  has_one :shipping_address
end
