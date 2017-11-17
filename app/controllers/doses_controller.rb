class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @ingredient = Ingredient.all
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.all

    @dose = Dose.new(dose_permitted)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render "new"
    end
  end

  def delete
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.destroy
    redirect_to @cocktail
  end

  private

  def dose_permitted
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)
  end
end


