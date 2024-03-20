class PantryItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = PantryItem.where(user_id: current_user.id)
    puts "Hola"
  end
end