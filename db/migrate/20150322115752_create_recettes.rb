class CreateRecettes < ActiveRecord::Migration
  def change
    create_table :recettes do |t|
      t.string :name
      t.text :instructions
      t.string :image
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
