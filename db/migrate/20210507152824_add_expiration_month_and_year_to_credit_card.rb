class AddExpirationMonthAndYearToCreditCard < ActiveRecord::Migration[6.1]
  def change
    add_column :credit_cards, :expiration_month, :integer, null: :false
    add_column :credit_cards, :expiration_year, :integer, null: :false
  end
end
