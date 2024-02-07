class Ingredient < ApplicationRecord
  has_and_belongs_to_many :recipes
  #searchkick text_middle: %i[:name, :detail]

  scope :by_q, -> (q) { where("lower(ingredients.name) LIKE ? OR lower(ingredients.detail) LIKE ?","%#{q}%", "%#{q}%").distinct}
end
