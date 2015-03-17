require 'spec_helper.rb'

feature "Chercher une recette", js: true do
  before do
    Recette.create!(name: 'Patates sauté au fromage')
    Recette.create!(name: 'Reste de patate douce')
    Recette.create!(name: 'Gratin de patates')
    Recette.create!(name: 'Tout le reste')
  end
  scenario "Trouver sa recette" do
    visit '/'
    fill_in "keywords", with: "fromage"
    click_on "Chercher"

    expect(page).to have_content("Patates sauté au fromage")
  end
end