class Recipe < ApplicationRecord
  has_and_belongs_to_many :ingredients
  has_one_attached :image
  belongs_to :user
  has_and_belongs_to_many :liking_users, class_name: "User", join_table: "likes"
  has_and_belongs_to_many :saving_users, class_name: "User", join_table: "saves"
  has_and_belongs_to_many :tags, join_table: "recipes_tags"

  validates :name, length: { minimum: 1, message: "Nombre muy corto"}
  validates :detail, length: { minimum: 1, message: "Descripción muy corto"}
end
