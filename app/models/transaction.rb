class Transaction < ApplicationRecord
  belongs_to :from_account, class_name: 'Account', optional: true
  belongs_to :to_account, class_name: 'Account'
  belongs_to :credit_card, optional: true

  validates_presence_of :credit_card, if: :credit_card?

  enum status: %i[pending success error], _default: "pending"
  enum transaction_type: %i[transfer credit_card], _default: "transfer"

  after_save :transfer_balance, if: -> { transfer? && pending? }
  after_save :process_credit_card, if: -> { credit_card? && pending? }

  private
    def from_account_has_enough_balance?
      self.from_account.balance >= self.amount
    end

    def transfer_balance
      self.transaction do
        begin
          self.from_account.transfer(self.amount, self.to_account)
          self.success!
        rescue
          self.error!
        end
      end
    end

    def process_credit_card
      self.transaction do
        self.to_account.deposit(self.amount)
        self.success!
      end
    end
end
