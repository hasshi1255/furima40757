FactoryBot.define do
  factory :item do
    name { 'Sample Item' }
    description { 'This is a sample item description.' }
    category_id { 2 }
    condition_id { 2 }
    shipping_cost_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    price { 1000 }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.jpg'), 'image/jpeg') }
  end
end
