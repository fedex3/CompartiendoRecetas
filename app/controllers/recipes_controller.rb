class RecipesController < ApplicationController
  #before_action :authenticate_user! , only: %i[new]

  def index
    @recipes = Recipe.all
  end

  def mine
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.includes(:ingredients).find(params[:id])
    @user = User.find(@recipe.user_id)
  end

  def new
    @recipe = Recipe.new
    @ingredients = []
    @user = current_user
    @recipe = current_user.recipes.build
  end

  def edit
  end

  def create
    #if recipe_params.ingredients.empty?
    new_params = recipe_params.except(:ingredients,:ingredients_ids)
    @recipe = Recipe.new(new_params)
    @recipe.user_id = current_user.id
    ingredients_ids_list = recipe_params[:ingredients_ids].to_s.split(',')
    unless ingredients_ids_list.empty?
      @ingredients = Ingredient.where(:id => ingredients_ids_list)
      @recipe.ingredients << @ingredients
      new_params[:ingredients] = @recipe.ingredients
    else
      puts "Esta receta no tiene ingredientes"
    end
    
    @recipe = current_user.recipes.build(new_params)
    #if recipe_params
    #@ingredients = Ingredient.where(:id => recipe_params[:ingredients])
    #@recipe.ingredients << @ingredients

    if @recipe.save
      redirect_to @recipe
    else
      puts @recipe.errors.full_messages
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
      params.require(:recipe).permit(:name, :detail, :cooking_time, :cooking_time_unit, :user_id, :image, :ingredients, :ingredients_ids)
    end

    #def companies
    #  @companies = scope(params)
    #end
end