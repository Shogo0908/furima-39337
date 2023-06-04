FactoryBot.define do
  factory :purchase_shipment do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市緑区' }
    address { '青山１−１' }
    building_name { '柳ビル' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
