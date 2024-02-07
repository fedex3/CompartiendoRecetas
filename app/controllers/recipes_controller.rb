class RecipesController < ApplicationController
  before_action :authenticate_user! , only: %i[new]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find(@recipe.users_id)
    
  end

  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all
    @user = current_user
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.users_id = current_user.id
    @ingredients = Ingredient.where(:id => params[:ingredients])
    @recipe.ingredients << @ingredients

    if @recipe.save
      redirect_to @recipe
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    @recipe.destroy
  end

  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :detail, :cooking_time, :cooking_time_unit, :users_id, :image, :ingredients)
    end

    #def companies
    #  @companies = scope(params)
    #end
end