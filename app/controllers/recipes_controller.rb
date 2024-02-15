class RecipesController < ApplicationController
  #before_action :authenticate_user! , only: %i[new]
  require 'json'

  def index
    @recipes = Recipe.all
  end

  def mine
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.includes(:ingredients).find(params[:id])
    @user = User.find(@recipe.user_id)
    @allow_edit = @user == current_user ? true : false
    puts @allow_edit
  end

  def new
    @recipe = Recipe.new
    @ingredients = []
    @user = current_user
    @recipe = current_user.recipes.build
  end

  def edit
    @recipe = Recipe.find(params[:id])
    puts @recipe.inspect
    puts @recipe.ingredients.inspect
  end

  def update
    @recipe = Recipe.find(params[:id])
    puts recipe_params.inspect
    new_params = recipe_params.except(:ingredients,:ingredients_ids)
    @recipe.ingredients.destroy_all
    ingredients_ids_list = recipe_params[:ingredients_ids].to_s.split(',')
    unless ingredients_ids_list.empty?
      @ingredients = Ingredient.where(:id => ingredients_ids_list)
      @recipe.ingredients << @ingredients
      new_params[:ingredients] = @recipe.ingredients
    else
      puts "Esta receta no tiene ingredientes"
    end

    if @recipe.update(new_params)
      flash[:success] = "Recipe updated!"
      redirect_to @recipe
    else
      render :edit
    end
  end

  def ai_recipe
    @recipe = Recipe.new
    @ingredients = []
    @user = current_user
    @recipe = current_user.recipes.build

    query = 'Generá una nueva receta. El formato de la receta debe ser json con la siguiente estructura: { "name": "sombre de la receta", "cooking_time": "Tiempo de preparación", "ingredients": [ "ingrediente1", "ingrediente2", …], "detail": "Descripción general de la receta e instrucciones para la preparación" }. En la lista de ingredientes no se debe especificar las cantidades, pero si en la sección de detail explicando la receta. No escribas ninguna oración antes o después del JSON.'
    response = OpenaiService.new(query).call

    #response = requests.post(url, headers=headers, json=data)
    #recipe = response.json()

    response_in_json = JSON.parse(response)

    @recipe.name = response_in_json["name"]
    @recipe.cooking_time = response_in_json["cooking_time"]
    @recipe.detail = response_in_json["detail"]
    response_in_json["ingredients"].each do |ingredient|
      ingredient_in_db = Ingredient.find_by(name: ingredient) || Ingredient.find_by(name: ingredient.upcase)
      if ingredient_in_db.nil?
        @ingredient = Ingredient.new()
        @ingredient.name = ingredient
        #OpenAI API no me deja hacer más de 3 calls por minuto. Además, esto hace que tarde demasiado en cargar
        #if response_in_json["ingredients"].length < 3 
        #  full_query_2 = "Dame una descripción para el ingrediente o comida #{ingredient}"
        #  @ingredient.detail = OpenaiService.new(full_query_2).call
        #end
        if @ingredient.save
          puts "Ingrediente nuevo guardado"
          @recipe.ingredients << @ingredient
        else
          puts @ingredient.errors.full_messages
        end
      else
        @recipe.ingredients << @ingredient_in_db
      end
    end

    puts @recipe.inspect
    puts @recipe.ingredients.inspect
    render :new
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


  def destroy
    @recipe.destroy
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :detail, :cooking_time, :cooking_time_unit, :user_id, :image, :ingredients, :ingredients_ids, ingredients_attributes: [:id, :name, :_destroy])
    end

    def recipes
      @recipes = scope.page(params[:page]).order_by_date
    end

    def recipe
      @recipe ||= scope.find(params[:id])
    end
end