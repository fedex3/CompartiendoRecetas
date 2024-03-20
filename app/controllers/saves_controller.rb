class SavesController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    current_user.saved_recipes << @recipe
    redirect_to @recipe, notice: "Recipe saved for later!"
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    current_user.saved_recipes.delete(@recipe)
    redirect_to @recipe, notice: "Recipe removed from saved."
  end
end