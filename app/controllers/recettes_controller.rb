class RecettesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
  	@recettes = if params[:keywords]
                 Recette.where('name like ?',"%#{params[:keywords]}%")
               else
                 Recette.all()
               end
  end

  def show
    @recette = Recette.find(params[:id])
  end

  def create
    @recette = Recette.new(params.require(:recette).permit(:name,:instructions))
    @recette.save
    render 'show', status: 201
  end

  def update
    recette = Recette.find(params[:id])
    recette.update_attributes(params.require(:recette).permit(:name,:instructions))
    head :no_content
  end

  def destroy
    recette = Recette.find(params[:id])
    recette.destroy
    head :no_content
  end
end
