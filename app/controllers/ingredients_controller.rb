class IngredientsController < ApplicationController
  def index
  end

  def create
    ingredient = Ingredient.new()
    ingredient.name         = params[:name]
    ingredient.save!
    head :no_content
  end

end
