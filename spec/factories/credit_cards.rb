FactoryBot.define do
  factory :credit_card do
    last_digits { Faker::Finance.credit_card.last(4) }
    expiration_date { Faker::Date.between(from: Date.today, to: 5.years.from_now) }
    holder_name { Faker::Name.name }
    user { build(:user) }
  end
end
