class RecettesController < ApplicationController
  def index
  	@recettes = if params[:keywords]
                 Recette.where('name like ?',"%#{params[:keywords]}%")
               else
                 []
               end
  end

  def show
    @recette = Recette.find(params[:id])
  end
end
