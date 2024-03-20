class Tag < ApplicationRecord
  has_and_belongs_to_many :recipes, join_table: "recipes_tags"
  has_and_belongs_to_many :users, join_table: "tags_users"
  has_and_belongs_to_many :ingredients, join_table: "ingredients_tags"
end