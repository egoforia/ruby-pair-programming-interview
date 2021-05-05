FactoryBot.define do
  factory :credit_card do
    last_digits { "MyString" }
    expiration_date { "2021-05-05" }
    holder_name { "MyString" }
    user { nil }
  end
end
