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

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    if @cocktail.update(cocktail_permitted)
      redirect_to @cocktail
    else
      render "edit"
    end
  end

  private

  def cocktail_permitted
    params.require(:cocktail).permit(:name, :photo, :photo_cache, doses_attributes: [:ingredient_id, :description, :_destroy, :cocktail_id])
  end
end
