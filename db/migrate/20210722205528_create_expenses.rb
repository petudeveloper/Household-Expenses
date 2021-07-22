class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :amount
      t.references :user_id, index: true, foreign_key: true, foreign_key: {to_table: :users}
      t.references :group_id, index: true, foreign_key: true, foreign_key: {to_table: :groups}

      t.timestamps
    end
  end
end
