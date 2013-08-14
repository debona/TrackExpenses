class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.integer :title_index
      t.integer :date_index
      t.integer :value_index
      t.string :column_separator

      t.timestamps
    end
  end
end
