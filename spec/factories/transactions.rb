FactoryBot.define do
  factory :transaction do
    amount { "9.99" }

    factory :transfer_transaction do
      from_account { build(:account) }
      to_account { build(:account) }
      transaction_type { "transfer" }
    end

    factory :credit_card_transaction do
      credit_card { build(:credit_card) }
      to_account { build(:account) }
      transaction_type { "credit_card" }
    end
  end
end
