class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, foreign_key: 'from_account_id'

  validates :user, presence: true
end
