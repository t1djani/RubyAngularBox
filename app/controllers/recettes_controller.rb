class RecettesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
  	@recettes = if params[:keywords]
                 Recette.where('name like ?',"%#{params[:keywords]}%")
               else
                @recettes = Recette.paginate(:page => params[:page], :per_page => 2)
               end
  end

  def show
    @recette = Recette.find(params[:id])
    @ingredients = @recette.ingredients
  end

  def create
    @recette = Recette.new()
    @recette.name = params[:name]
    @recette.instructions = params[:instructions]
    @recette.image = params[:image]
    @recette.save!
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
