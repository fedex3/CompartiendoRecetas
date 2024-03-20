class CreateJoinTableIngredientsTags < ActiveRecord::Migration[7.1]
  def change
    create_join_table :ingredients, :tags do |t|
      t.index [:ingredient_id, :tag_id]
      t.index [:tag_id, :ingredient_id]

      t.timestamps
    end
  end
end
