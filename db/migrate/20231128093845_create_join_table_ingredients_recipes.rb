class CreateJoinTableIngredientsRecipes < ActiveRecord::Migration[7.1]
  def change
    create_join_table :ingredients, :recipes do |t|
      t.index [:ingredient_id, :recipe_id]
      t.index [:recipe_id, :ingredient_id]

      t.timestamps
    end
  end
end
