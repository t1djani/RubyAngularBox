class CreateCarnets < ActiveRecord::Migration
  def change
    create_table :carnets do |t|
      t.string :book
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
