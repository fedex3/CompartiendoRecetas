class Recipe < ApplicationRecord
  has_and_belongs_to_many :ingredients
  has_one_attached :image
  belongs_to :user
  #validates
end
