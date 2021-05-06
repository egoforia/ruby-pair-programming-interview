class User < ApplicationRecord
  has_many :accounts
  has_many :credit_cards
  validates :first_name, :last_name, presence: true

  def balance_total
    self.accounts.sum(:balance)
  end
end
