class Transaction < ApplicationRecord
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  enum status: %i[pending success error], _default: "pending"
  enum transaction_type: %i[transfer], _default: "transfer" # should we add more transaction types (e.g. credit_card)?
end
