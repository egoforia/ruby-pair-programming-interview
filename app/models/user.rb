class User < ApplicationRecord
  has_many :accounts
  has_many :credit_cards
  validates :first_name, :last_name, presence: true
end
