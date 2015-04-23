class RecettesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    recettes = if params[:keywords]
                 Recette.where('name like ?',"%#{params[:keywords]}%")
                  .paginate(page: params[:page], per_page: 9)
               else
                 Recette.paginate(page: params[:page], per_page: 9)
               end

    render json: {
      recettes: recettes,
      totalItem: Recette.all.count,
      searchItem: recettes.count
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
    recette = Recette.new()
    recette.name         = params[:name]
    recette.instructions = params[:instructions]
    recette.image        = params[:image]
    recette.user_id      = params[:user_id]
    if params[:ingredients]
      ingredient = params[:ingredients].split(",")
      ingredient.each do |ingredient_str|
        ingredient = Ingredient.find_or_create_by(name: ingredient_str)
        recette.ingredients <<  ingredient
      end
    end
    recette.save!
    head :no_content
  end

  def update
    recette = Recette.find( params[:id] )
    recette.name         = params[:name]
    recette.instructions = params[:instructions]
    recette.image        = params[:image] if params[:image]
    if params[:ingredients]
      recette.ingredients.delete_all
      ingredient = params[:ingredients].split(",")
      ingredient.each do |ingredient_str|
        ingredient = Ingredient.find_or_create_by(name: ingredient_str)
        recette.ingredients <<  ingredient
      end
    end
    recette.save!
    head :no_content
  end

  def destroy
    recette = Recette.find(params[:id])
    recette.destroy
    head :no_content
  end

  def add_to_carnet
    recette = Recette.find( params[:id] )
    carnet = Carnet.find( params[:carnet_id] )
    if carnet.recettes.find_by(id: recette.id )
      head :bad_request
    else
      carnet.recettes << recette
      carnet.save
      head :no_content
    end
  end
end
