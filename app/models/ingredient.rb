class Ingredient < ApplicationRecord
  has_and_belongs_to_many :recipes
  has_and_belongs_to_many :tags, join_table: "ingredients_tags"
  #searchkick text_middle: %i[:name, :detail]

  scope :by_q_init, -> (q) { where("lower(ingredients.name) LIKE ? OR lower(ingredients.detail) LIKE ?","#{q}%", "#{q}%").distinct}
  scope :by_q_any, -> (q) { where("lower(ingredients.name) LIKE ? OR lower(ingredients.detail) LIKE ?","%#{q}%", "%#{q}%").distinct}
end
