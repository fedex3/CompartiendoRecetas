class CreateJoinTableSavesUsersRecipes < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :recipes, table_name: :saves do |t|
      t.index [:user_id, :recipe_id]
      t.index [:recipe_id, :user_id]

      t.timestamps
    end
  end
end
