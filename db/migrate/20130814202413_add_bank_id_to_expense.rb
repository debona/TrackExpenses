class AddBankIdToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :bank_id, :integer
  end
end
