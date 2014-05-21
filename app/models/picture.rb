class Picture < ActiveRecord::Base
  belongs_to :album

  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation, :picture_image, :tag_list
  mount_uploader :picture_image, PictureImageUploader
  #after validation, save these items into the database. this would allow us to see pictures nearby by pulling them from the database.
  before_save :save_exif

  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation

  acts_as_taggable
  acts_as_votable
  acts_as_commentable

  def user
    album.user
  end

  def exif_data
    exif_info = case File.extname(picture_image.path).upcase
    when '.JPG'
      EXIFR::JPEG.new(picture_image.path)
    when '.TIFF'
      EXIFR::TIFF.new(picture_image.path)
    else
      nil
    end
  end

  # def save_exif
  #     if picture_image.present?
  #     :camera_model => self.exif_data.model
  #     end
  # end

  # @image.exif_data.date_time for example (in not nil or error will happen)
  
end

