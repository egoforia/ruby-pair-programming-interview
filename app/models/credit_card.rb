class CreditCard < ApplicationRecord
  belongs_to :user

  validates :user, :holder_name, :last_digits, :expiration_date, :expiration_month, :expiration_year, presence: true
  validates_presence_of :number, :expiration_month, :expiration_year, on: :create
  validates_length_of :last_digits, is: 4

  validate :expiration_date_cannot_be_in_the_past

  attribute :number, :string

  before_validation :set_last_digits, unless: -> { self.number.blank? }
  before_validation :set_expiration_date, unless: -> { self.expiration_year.blank? || self.expiration_month.blank? }

  private
    def expiration_date_cannot_be_in_the_past
      if self.expiration_date.present? && self.expiration_date < Date.today.beginning_of_month
        self.errors.add(:expiration_date, "can't be in the past")
      end
    end

    def set_expiration_date
      self.expiration_date = Date.new(self.expiration_year, self.expiration_month, 1)
    end

    def set_last_digits
      self.last_digits = self.number.last(4)
    end
end
