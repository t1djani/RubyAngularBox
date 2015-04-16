class Carnet < ActiveRecord::Base
  has_and_belongs_to_many :recettes
end
