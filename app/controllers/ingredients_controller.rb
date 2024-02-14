class IngredientsController < ApplicationController
  #require 'chatgpt_service'
  def index
    if params[:by_q].present?
      @ingredients = Ingredient.by_q_init(params[:by_q]).first(10)
      if @ingredients.count < 10          
        @ingredients += Ingredient.by_q_any(params[:by_q]).first(10 - @ingredients.count)
      end
    else
      @ingredients = Ingredient.first(10)
    end
    
    render json: @ingredients.uniq.pluck(:name, :id)   
  end

  def new
    if params[:query]
      full_query = "¿Es #{params[:query]} un ingrediente o comida válida para una receta? Solo responder con 'true' si es válido o 'false' si es inválido y nada más"
      @response = OpenaiService.new(full_query).call
      if @response == 'true'
        @ingredient = Ingredient.new()
        @ingredient.name = params[:query]
        full_query_2 = "Dame una descripción para el ingrediente o comida #{params[:query]}"
        @ingredient.detail = OpenaiService.new(full_query_2).call
        if @ingredient.save
          render json: [@ingredient.name, @ingredient.detail]
        else
          puts @ingredient.errors.full_messages
        end
      else
        render json: ["false"]
      end
    else
      puts "Query vacía"
    end
  end
end