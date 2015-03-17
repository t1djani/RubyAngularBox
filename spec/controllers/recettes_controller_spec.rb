require 'spec_helper'

describe RecettesController do
  render_views
  describe "index" do
    before do
      Recette.create!(name: 'Patates sauté au fromage')
      Recette.create!(name: 'Reste de patate douce')
      Recette.create!(name: 'Gratin de patates')
      Recette.create!(name: 'Tout le reste')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "quand la recherche donne une résultat" do
      let(:keywords) { 'reste' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'doit retourner 2 résultats' do
        expect(results.size).to eq(2)
      end
      it "doit inclure 'Reste de patate douce'" do
        expect(results.map(&extract_name)).to include('Reste de patate douce')
      end
      it "doit inclure 'Tout le reste'" do
        expect(results.map(&extract_name)).to include('Tout le reste')
      end
    end

    context "quand la recherche ne donne pas de résultats" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end
  
  describe "show" do
    before do
      xhr :get, :show, format: :json, id: recette_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "quand la recette existe" do
      let(:recette) { 
        Recette.create!(name: 'Patates au fromage', 
               instructions: "Cuire 20 min ; Mettre du fromage") 
      }
      let(:recette_id) { recette.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(recette.id) }
      it { expect(results["name"]).to eq(recette.name) }
      it { expect(results["instructions"]).to eq(recette.instructions) }
    end

    context "quand la recette n'existe pas" do
      let(:recette_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end  
end