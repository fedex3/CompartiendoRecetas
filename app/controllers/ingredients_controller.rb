class IngredientsController < ApplicationController
  def index
    if params[:by_q].present?
      @ingredients = Ingredient.by_q(params[:by_q])
      #@ingredients = Ingredient.where("lower(name) LIKE ? OR lower(detail) LIKE ?", "%#{params[:by_q]}%", "%#{params[:by_q]}%")
    else
      @ingredients = Ingredient.all
    end

    render json: @ingredients.pluck(:name)   
  end
end