class CarnetsController < ApplicationController
  def index
    if current_user
      carnets = Carnet.where( user_id: current_user.id)
        .paginate(page: params[:page], per_page: 5)

      render json: {
        carnets: carnets,
        totalItem: carnets.count
      }
    end
  end


  def create
    carnet = Carnet.new()
    carnet.book         = params[:book]
    carnet.description = params[:description]
    carnet.user_id      = current_user.id
    carnet.save!
    head :no_content
  end

  def show
    carnet = Carnet.find(params[:id])
    recettes = carnet.recettes.paginate(page: params[:page], per_page: 3)

    render json: {
      carnet: carnet,
      recettes: recettes,
      totalItem: carnet.recettes.count
    }
  end

  def update
    carnet = Carnet.find( params[:id] )
    carnet.book = params[:book]
    carnet.description = params[:description]
    carnet.save!
    head :no_content
  end

  def destroy
    carnet = Carnet.find(params[:id])
    carnet.destroy
    head :no_content
  end

  def show_recette
    recette = Recette.find( params[:id] )
    ingredients = recette.ingredients

    render json: {
      recette: recette,
      ingredients: ingredients
    }
  end

  def modal_carnets
    carnets = Carnet.where( user_id: current_user.id)

    render json: {
      carnets: carnets
    }
  end

  def delete_to_carnet
   recette = Recette.find( params[:id] )
   carnet = recette.carnets.find( params[:carnet_id] )
   if carnet
      recette.carnets.delete(carnet)
   end
   head :ok
  end

end
