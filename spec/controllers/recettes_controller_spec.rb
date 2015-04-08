require 'rails_helper'

describe RecettesController do

  describe "GET 'show'" do
    before(:each) do
      @recipe1 = Recette.create(name: "Test", instructions: "dqsdqs")
      @recipe2 = Recette.create(name: "test222", instructions: "fsdqfs")
    end
    it "returns http success" do
      get 'show', id: @recipe1.id
      expect(response).to be_success
    end
    it "return the right recipe if exist" do
      get "show", id: @recipe1.id
      expect(response.body).to have_node(:id).with(@recipe1.id)
    end
    it "doesnt return wrong recipe" do
      get "show", id: @recipe1.id
      expect(response.body).not_to have_node(:id).with(@recipe2.id)
    end
    it "return http error if recipe doesnt exist" do
      get "show", id: 23
      expect(response).not_to be_success
    end
  end

  describe "get 'index" do
    before(:each) do
      @recipe1 = Recette.create(name: "Test", instructions: "dqsdqs")
      @recipe2 = Recette.create(name: "test222", instructions: "fsdqfs")
      @recipe3 = Recette.create(name: "recipe3", instructions: "fsdqsdqss")
      @recipe4 = Recette.create(name: "recipe4", instructions: "fsdqffvcvxcs")
    end
    it "return http success" do
      get "index"
      expect(response).to be_success
    end
    it "if no params return two recipes" do
      get "index"
      expect(response.body).to have_node(:id).with(@recipe1.id)
      expect(response.body).to have_node(:id).with(@recipe2.id)
      expect(response.body).not_to have_node(:id).with(@recipe3.id)
    end
    it "if no params page return page = 1" do
      get "index", page: nil
      expect(response.body).to have_node(:id).with(@recipe1.id)
      expect(response.body).to have_node(:id).with(@recipe2.id)
      expect(response.body).not_to have_node(:id).with(@recipe4.id)
    end
    it "if page = 2" do
      get "index", page: 2
      expect(response.body).to have_node(:id).with(@recipe3.id)
      expect(response.body).not_to have_node(:id).with(@recipe1.id)
    end
    it "if there is keyword" do
      get "index", keywords: "test"
      expect(response.body).to have_node(:name).with("test222")
      expect(response.body).to have_node(:name).with("Test")
      expect(response.body).not_to have_node(:name).with(@recipe4.name)
    end
    it "if there is no keywords" do
      get "index", keywords: nil
      expect(response.body).to have_node(:name).with("test222")
      expect(response.body).to have_node(:name).with("Test")
      expect(response.body).not_to have_node(:name).with(@recipe4.name)
    end
  end
end
