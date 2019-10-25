class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :destroy, :edit, :update]
  def index
    if params[:search].nil?
      @cocktails = Cocktail.all
    else
      @cocktails_one = Cocktail.where('name ILIKE ?', '%' + params[:search][:name] + '%' )
      @ingredients = Ingredient.where('name ILIKE ?', '%' + params[:search][:name] + '%' ).pluck(:id)
      @doses = Dose.where(ingredient_id: @ingredients).pluck(:cocktail_id)
      @cocktails_two = Cocktail.where(id: @doses)
      @cocktails = (@cocktails_one + @cocktails_two).uniq
    end
  end

  def show
    @dose = Dose.new
    @ingredient = Ingredient.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save
    redirect_to cocktails_path
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  def edit
  end

  def update
    @cocktail.update(name: params[:cocktail][:name], image_url: params[:cocktail][:image_url], photo: params[:cocktail][:photo])
    redirect_to cocktail_path(@cocktail)
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :image_url, :photo)
  end
end
