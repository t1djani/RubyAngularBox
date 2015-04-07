class RecetteSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :image
end
