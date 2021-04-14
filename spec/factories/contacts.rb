FactoryBot.define do
  factory :contact do
    name { 'Fake-name' }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone_number { "(+57) 320-432-05-09" }
    address { Faker::Address.full_address }
    credit_card_number { "6011987824047882" }
    credit_card_type { "Discover" }
    email { Faker::Internet.unique.email }
    user_id { csv.user_id }
    csv

    trait :custom_email do
      email { 'custom_email@gmail.com' }
    end
  end
end
