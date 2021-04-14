FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { '12345678' }

    trait :custom_email do
      email { 'custom_email@gmail.com' }
    end
  end
end
