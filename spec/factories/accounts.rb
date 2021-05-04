FactoryBot.define do
  factory :account do
    user { build(:user) }

    factory :account_with_balance do
      transient do
        balance { 0.0 }
      end

      before(:create) do |account, evaluator|
        account.balance = evaluator.balance
      end
    end
  end
end
