FactoryBot.define do
  factory :shipment do
    postal_code { 'MyString' }
    prefecture_id { 1 }
    city { 'MyString' }
    address { 'MyString' }
    building_name { 'MyString' }
    phone_number { 'MyString' }
    purchase { nil }
  end
end
