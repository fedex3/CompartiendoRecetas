class RecipesController < ApplicationController
  #before_action :authenticate_user! , only: %i[new]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find(@recipe.user_id)
    
  end

  def new
    @recipe = Recipe.new
    @ingredients = []
    @user = current_user
    @recipe = current_user.recipes.build

    puts "hola"
  end

  def edit
  end

  def create
    #if recipe_params.ingredients.empty?
    puts("|||||||||||||||||||||||||||||||||||")


    #puts(recipe_params)
    @recipe = Recipe.new(recipe_params.except(:ingredients))
    puts current_user
    @recipe.user_id = current_user.id
    @recipe = current_user.recipes.build(recipe_params.except(:ingredients))
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
      params.require(:recipe).permit(:name, :detail, :cooking_time, :cooking_time_unit, :user_id, :image, :ingredients)
    end

    #def companies
    #  @companies = scope(params)
    #end
end