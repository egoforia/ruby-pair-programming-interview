class Transaction < ApplicationRecord
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  enum status: %i[pending success error], _default: "pending"
  enum transaction_type: %i[transfer], _default: "transfer" # should we add more transaction types (e.g. credit_card)?

  after_save :transfer_balance, if: :pending?

  private
    def from_account_has_enough_balance?
      self.from_account.balance >= self.amount
    end

    def transfer_balance
      self.transaction do
        if self.from_account_has_enough_balance?
          self.from_account.update_attribute(:balance, self.from_account.balance - self.amount)
          self.to_account.update_attribute(:balance, self.to_account.balance + self.amount)
          self.success!
        else
          self.error!
        end
      end
    end
end
