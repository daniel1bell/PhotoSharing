class AddPictureImageToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :picture_image, :string
  end
end
