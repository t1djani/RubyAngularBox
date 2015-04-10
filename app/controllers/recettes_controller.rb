class RecettesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    recettes = if params[:keywords]
                 Recette.where('name like ?',"%#{params[:keywords]}%")
                  .paginate(page: params[:page], per_page: 3)
               else
                 Recette.paginate(page: params[:page], per_page: 3)
               end

    totalItem = Recette.all.count
    searchItem = recettes.count

    render json: {
      recettes: recettes,
      totalItem: totalItem,
      searchItem: searchItem
    }
  end

  def show
    recette = Recette.find(params[:id])
    ingredients = recette.ingredients
    render json: {
      recette: recette,
      ingredients: ingredients
    }
  end

  def create
    @recette = Recette.new()
    @recette.name         = params[:name]
    @recette.instructions = params[:instructions]
    @recette.image        = params[:image]
    @recette.save!
    head :no_content
  end

  def update
    recette = Recette.find( params[:id] )
    recette.name         = params[:name]
    recette.instructions = params[:instructions]
    recette.image        = params[:image] if params[:image]
    recette.save!
    head :no_content
  end

  def destroy
    recette = Recette.find(params[:id])
    recette.destroy
    head :no_content
  end
end
