FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.characters(number: 1000) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id { Faker::Number.between(from: 2, to: 10) } 
    condition_id { Faker::Number.between(from: 2, to: 10) }
    delivery_fee_id { Faker::Number.between(from: 2, to: 10) } 
    prefecture_id { Faker::Number.between(from: 2, to: 10) } 
    shipping_date_id { Faker::Number.between(from: 2, to: 10) }
  end
end
