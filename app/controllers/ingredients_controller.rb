class IngredientsController < ApplicationController
  def new
    @ingredient = Ingredient.new
  end

  def create
    @new_i = Ingredient.new(name: params[:ingredient][:name])
    @new_i.save
    redirect_to cocktail_path(params[:ingredient][:cocktail])
  end
end
