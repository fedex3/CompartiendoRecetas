class RemoveCookingTimeAndUnitFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :cooking_time, :float
    remove_column :recipes, :cooking_time_unit, :string
    add_column :recipes, :cooking_time, :string
  end
end
