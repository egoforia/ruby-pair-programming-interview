class CreditCard < ApplicationRecord
  belongs_to :user

  validates :user, :holder_name, :last_digits, :expiration_date, presence: true
  validate :expiration_date_cannot_be_in_the_past

  private
    def expiration_date_cannot_be_in_the_past
      if expiration_date.present? && expiration_date < Date.today
        errors.add(:expiration_date, "can't be in the past")
      end
    end
end
