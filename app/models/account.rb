class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, foreign_key: 'from_account_id'

  validates :user, presence: true

  def withdraw(amount)
    self.update_attribute(:balance, self.balance - amount)
  end

  def deposit(amount)
    self.update_attribute(:balance, self.balance + amount)
  end

  def transfer(amount, to_account)
    if self.balance >= amount
      self.withdraw(amount)
      to_account.deposit(amount)
    else 
      raise 'Not enough balance'
    end
  end
end
