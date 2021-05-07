class CreditCard < ApplicationRecord
  belongs_to :user

  validates :user, :holder_name, :expiration_date, presence: true
  validates_length_of :last_digits, is: 4

  validate :expiration_date_cannot_be_in_the_past

  attribute :number, :string

  validates_presence_of :number, on: :create

  before_validation :set_last_digits

  private
    def expiration_date_cannot_be_in_the_past
      if expiration_date.present? && expiration_date < Date.today
        errors.add(:expiration_date, "can't be in the past")
      end
    end

    def set_last_digits
      self.last_digits = self.number.last(4) unless self.number.blank?
    end
end
