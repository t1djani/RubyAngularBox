require 'spec_helper.rb'

feature "Créer, editer et supprimer une recette", js: true do
  scenario "CRUD" do
    visit '/'
    click_on "Nouvelle recette"

    fill_in "name", with: "Patates au fromage"
    fill_in "instructions", with: "plonger dans l'huile et cuire"

    click_on "Sauvegarder"

    expect(page).to have_content("Patates au fromage")
    expect(page).to have_content("plonger dans l'huile et cuire")

    click_on "Editer"

    fill_in "name", with: "Patates Douces"
    fill_in "instructions", with: "Plonger dans l'huile et chauffer"

    click_on "Sauvegarder"

    expect(page).to have_content("Patates Douces")
    expect(page).to have_content("chauffer")

    visit "/"
    fill_in "keywords", with: "Douces"
    click_on "Chercher"

    click_on "Patates Douces"

    click_on "Supprimer"

    expect(Recette.find_by_name("Patates Douces")).to be_nil

  end
end