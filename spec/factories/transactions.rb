FactoryBot.define do
  factory :transaction do
    amount { "9.99" }
    from_account { nil }
    to_account { nil }
    status { 1 }
    transaction_type { 1 }
  end
end
