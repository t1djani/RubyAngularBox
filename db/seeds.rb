# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
recipes_list = [
  [ "Patates au fromages", 'Cuire 40min, blablabla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla', 'wallhaven-95015.jpg'],
  [ "Patates douces", 'La douceur', 'wallhaven-75030.jpg'],
  [ "Pates au saumon", 'Ajouter saumon, fondre, cuire tout sa', 'wallhaven-29165.jpg'],
  [ "Makki Sushi", 'Couper, preparer, secher', 'wallhaven-129341.jpg']
]

recipes_list.each do |name, instructions, image|
  Recette.create( name: name, instructions: instructions, image: image )
end
