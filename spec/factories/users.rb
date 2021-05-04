FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    factory :user_with_account do
      after(:create) do |user, evaluator|
        create(:account, user: user)

        user.reload
      end
    end
  end
end
