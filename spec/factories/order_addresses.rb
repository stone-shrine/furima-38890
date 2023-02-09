FactoryBot.define do
  factory :order_address do
    zip_code      { '123-4567' }
    prefecture_id { Prefecture.where.not(id: 1).sample.id }
    city          { Faker::Address.city }
    street        { Faker::Address.street_address }
    building      { Faker::Address.building_number }
    phone         { Faker::Number.number(digits: 11) }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
