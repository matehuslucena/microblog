FactoryGirl.define do
  factory :post do
    body Faker::Lorem.sentence(3)
    association :user, factory: :another_user
  end

  factory :invalid_post, parent: :post do
    body nil
  end
end
