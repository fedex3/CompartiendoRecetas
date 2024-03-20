class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    current_user.liked_recipes << @recipe
    redirect_to @recipe, notice: "Recipe liked!"
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    current_user.liked_recipes.delete(@recipe)
    redirect_to @recipe, notice: "Recipe unliked."
  end
end