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
      expect(subject).to have_node(:id).with(@recipe1.id)
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
      @recipe5 = Recette.create(name: "recipe5", instructions: "fsdqfsdfqdffvcvxcs")
    end

    subject { response.body }

    it "return http success" do
      get "index"
      expect(response).to be_success
    end

    it "" do
      get "index"
      expect(subject).to have_node(:id).with(@recipe1.id)
      expect(subject).to have_node(:id).with(@recipe2.id)
      expect(subject).not_to have_node(:id).with(@recipe3.id)
    end

    it "if no params page return page = 1" do
      get "index", page: nil
      expect(subject).to have_node(:id).with(@recipe1.id)
      expect(subject).to have_node(:id).with(@recipe2.id)
      expect(subject).not_to have_node(:id).with(@recipe4.id)
    end

    it "if page = 2" do
      get "index", page: 2
      expect(subject).to have_node(:id).with(@recipe3.id)
      expect(subject).not_to have_node(:id).with(@recipe1.id)
    end

    it "if there is params keyword" do
      get "index", keywords: "test"
      expect(subject).to have_node(:name).with("test222")
      expect(subject).to have_node(:name).with("Test")
      expect(subject).not_to have_node(:name).with(@recipe4.name)
    end

    it "if there is no keywords" do
      get "index", keywords: nil
      expect(subject).to have_node(:name).with("test222")
      expect(subject).to have_node(:name).with("Test")
      expect(subject).not_to have_node(:name).with(@recipe4.name)
    end

    it "pagination with search page = 1" do
      get "index", keywords: "recipe", page: 1
      expect(subject).to have_node(:name).with(@recipe3.name)
      expect(subject).not_to have_node(:name).with(@recipe5.name)
    end

    it "pagination with search page = 2" do
      get "index", keywords: "recipe", page: 2
      expect(subject).to have_node(:name).with(@recipe5.name)
      expect(subject).not_to have_node(:name).with(@recipe3.name)
    end
  end
end
