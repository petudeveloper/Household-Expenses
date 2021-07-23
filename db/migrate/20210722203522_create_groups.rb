class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :icon
      t.references :user_id, index: true, foreign_key: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
