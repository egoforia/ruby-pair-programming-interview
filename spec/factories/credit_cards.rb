FactoryBot.define do
  factory :credit_card do
    number { Faker::Finance.credit_card }
    expiration_month { Faker::Date.between(from: Date.today, to: 5.years.from_now).month }
    expiration_year { Faker::Date.between(from: 1.year.from_now, to: 5.years.from_now).year }
    holder_name { Faker::Name.name }
    user { build(:user) }  
  end
end
