class Recette < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
