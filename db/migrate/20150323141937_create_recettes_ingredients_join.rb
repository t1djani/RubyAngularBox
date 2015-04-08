class CreateRecettesIngredientsJoin < ActiveRecord::Migration
	def self.up
    	create_table 'ingredients_recettes', :id => false do |t|
      		t.column 'recette_id', :integer
      		t.column 'ingredient_id', :integer
    	end
  	end

  def self.down
    drop_table 'recettes_ingredients'
  end
end
