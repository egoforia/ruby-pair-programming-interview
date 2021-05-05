class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :last_digits, null: false
      t.date :expiration_date, null: false
      t.string :holder_name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
