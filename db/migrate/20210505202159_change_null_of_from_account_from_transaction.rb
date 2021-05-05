class ChangeNullOfFromAccountFromTransaction < ActiveRecord::Migration[6.1]
  def change
    change_column_null :transactions, :from_account_id, true
  end
end
