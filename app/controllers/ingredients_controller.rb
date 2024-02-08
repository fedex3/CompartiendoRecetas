class IngredientsController < ApplicationController
  def index
    if params[:by_q].present?
      @ingredients = Ingredient.by_q_init(params[:by_q]).first(10)
      if @ingredients.count < 10
        @ingredients += Ingredient.by_q_any(params[:by_q]).first(10 - @ingredients.count)
      end
    else
      @ingredients = Ingredient.first(10)
    end

    render json: @ingredients.pluck(:name, :id)   
  end
end