class CreateGroupExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :group_expenses do |t|
      t.references :group, index: true, foreign_key: true, foreign_key: {to_table: :groups}
      t.references :expense, index: true, foreign_key: true, foreign_key: {to_table: :expenses}

      t.timestamps
    end
  end
end
