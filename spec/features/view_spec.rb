require 'spec_helper.rb'

feature "Voir une recette", js: true do
  before do
    Recette.create!(name: 'Patates au fromage', 
           instructions: "cuire 20min")

    Recette.create!(name: 'Patates douces',
           instructions: 'plonger dans l\'huile et cuire')
  end
  scenario "Voir une recette" do
    visit '/'
    fill_in "keywords", with: "fromage"
    click_on "Chercher"

    click_on "Patates au fromage"

    expect(page).to have_content("Patates au fromage")
    expect(page).to have_content("plonger dans l'huile")

    click_on "Back"

    expect(page).to     have_content("Patates au fromage")
    expect(page).to_not have_content("plonger dans l'huile")
  end
end