FactoryGirl.define do
  factory :user do
    name "John"
    email  "john@j.com"
    password 123456
    password_confirmation 123456
  end

  factory :another_user, parent: :user do
    name Faker::Name.name
    email Faker::Internet.email
  end
end
