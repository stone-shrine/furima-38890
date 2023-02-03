FactoryBot.define do
  factory :item do
    name        { Faker::Internet.username }
    description { Faker::Lorem.sentence }
    category    { Category.where.not(id: 1).sample }
    status      { Status.where.not(id: 1).sample }
    payment     { Payment.where.not(id: 1).sample }
    prefecture  { Prefecture.where.not(id: 1).sample }
    lead_time   { LeadTime.where.not(id: 1).sample }
    price       { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
