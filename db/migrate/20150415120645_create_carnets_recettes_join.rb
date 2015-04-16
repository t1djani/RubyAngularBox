class CreateCarnetsRecettesJoin < ActiveRecord::Migration
  def change
    create_table 'carnets_recettes', :id => false do |t|
      t.column 'recette_id', :integer
      t.column 'carnet_id', :integer
    end
  end

  def self.down
    drop_table 'carnets_recettes'
  end
end
