class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :amount
      t.references :user, index: true, foreign_key: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
