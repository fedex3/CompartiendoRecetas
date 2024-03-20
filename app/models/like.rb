class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recipe, class_name: "Recipe", foreign_key: "recipe_id"
end
