FactoryBot.define do
  factory :item do
    name { 'Sample Item' }
    description { 'This is a sample item description.' }
    category_id { 1 }
    condition_id { 1 }
    shipping_cost_id { 1 }
    prefecture_id { 1 }
    shipping_day_id { 1 }
    price { 1000 }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.jpg'), 'image/jpeg') }
  end
end
