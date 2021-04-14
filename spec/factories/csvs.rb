FactoryBot.define do
  factory :csv do
    file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/contacts.csv")}
    user { association :user }

    trait :custom_id do
      id { 1 }
    end
  end
end
