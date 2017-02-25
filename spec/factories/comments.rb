FactoryGirl.define do
  factory :comment do
    name Faker::Name.name
    body Faker::Lorem.sentence(3)
    association :user, factory: :user
    association :post, factory: :post
  end

  factory :invalid_comment, parent: :comment do
    body nil
  end
end
