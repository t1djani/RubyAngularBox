class Recette < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	has_and_belongs_to_many :ingredients
	has_and_belongs_to_many :carnets
end
