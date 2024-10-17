FactoryBot.define do
  factory :item do
    name { 'サンプル商品' }
    description { 'サンプル商品の説明' }
    price { 1000 }
    category_id { 1 }
    item_status_id { 1 }
    shipping_cost_id { 1 }
    prefecture_id { 1 }
    shipping_date_id { 1 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end