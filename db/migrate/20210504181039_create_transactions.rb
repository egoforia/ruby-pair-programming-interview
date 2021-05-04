class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.references :from_account, index: true, null: false, foreign_key: { to_table: :accounts }
      t.references :to_account, index: true, null: false, foreign_key: { to_table: :accounts }
      t.integer :status, null: false
      t.integer :transaction_type, null: false

      t.timestamps
    end
  end
end
