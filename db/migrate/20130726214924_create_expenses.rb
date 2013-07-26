class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :title
      t.date :operation_date
      t.decimal :value

      t.timestamps
    end
  end
end
