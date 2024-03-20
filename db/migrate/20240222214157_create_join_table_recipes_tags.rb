class CreateJoinTableRecipesTags < ActiveRecord::Migration[7.1]
  def change
    create_join_table :recipes, :tags do |t|
      t.index [:recipe_id, :tag_id]
      t.index [:tag_id, :recipe_id]

      t.timestamps
    end
  end
end
