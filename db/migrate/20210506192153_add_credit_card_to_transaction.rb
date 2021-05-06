class AddCreditCardToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :credit_card, null: true, foreign_key: true
  end
end
