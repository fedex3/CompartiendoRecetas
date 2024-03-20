class AddForeignKeysToJoinTables < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :ingredients_recipes, :ingredients
    add_foreign_key :ingredients_recipes, :recipes
    add_foreign_key :likes, :users
    add_foreign_key :likes, :recipes
    add_foreign_key :saves, :users
    add_foreign_key :saves, :recipes
  end
end
