class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
    @ingredients = Ingredient.all.order("name asc")
  end

  def create
    @cocktail = Cocktail.new(cocktail_permitted)
    if @cocktail.save
      redirect_to @cocktail
    else
      render "new"
    end
  end

  private

  def cocktail_permitted
    params.require(:cocktail).permit(:name, doses_attributes: [:ingredient_id, :description])
  end
end
