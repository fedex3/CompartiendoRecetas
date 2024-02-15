class SearchController < ApplicationController
  def index
    @results = search_for_ingredients
    respond_to do |format|
      format.turbo_stream do
        redner turbo_stream:
        turbo_stream.update("ingredients", partial: "ingredients/index", locals: {ingredients: @results})
      end
    end
  end


  private
    def search_for_ingredients
      if params[:query].blank?
        Ingredient.all
      else
        Ingredient.search(params[:query], fields: %i[name detail], operator: "or", match: :text_middle)
      end
    end
end