class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes
  has_and_belongs_to_many :liked_recipes, class_name: "Recipe", join_table: "likes"
  has_and_belongs_to_many :saved_recipes, class_name: "Recipe", join_table: "saves"
  has_and_belongs_to_many :tags, join_table: "tags_users"
  has_one_attached :image


  validates :name, length: { minimum: 1, message: "Nombre muy corto"}
end
