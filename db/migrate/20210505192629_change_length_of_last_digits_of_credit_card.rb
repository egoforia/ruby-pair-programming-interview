class ChangeLengthOfLastDigitsOfCreditCard < ActiveRecord::Migration[6.1]
  def change
    change_column :credit_cards, :last_digits, :string, limit: 4
  end
end
