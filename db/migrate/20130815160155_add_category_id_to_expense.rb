class AddCategoryIdToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :category_id, :integer
  end
end
