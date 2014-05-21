class Picture < ActiveRecord::Base
  belongs_to :album


  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation, :picture_image, :tag_list
  mount_uploader :picture_image, PictureImageUploader
  #after validation, save these items into the database. this would allow us to see pictures nearby by pulling them from the database.
  before_save :update_exif

  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation

  acts_as_taggable
  acts_as_votable
  acts_as_commentable
  make_flaggable

  PictureImageUploader

  scope :most_liked, select("pictures.*, count(votes.id) as vote_count").joins("JOIN votes ON pictures.id = votes.votable_id").group("pictures.id").order("vote_count DESC")
  scope :most_commented, select("pictures.*, count(comments.id) as comment_count").joins("JOIN comments ON pictures.id = comments.commentable_id").group("pictures.id").order("comment_count DESC")
  scope :most_recent, where("pictures.created_at >= ?", 1.day.ago.utc).order("pictures.created_at DESC")

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

  private
  def update_exif
      self.camera_model = self.exif_data.model
      self.datetime = self.exif_data.date_time
      self.exposure = self.exif_data.try(:exposure_time)
      self.latitude = self.exif_data.try(:gps).try(:latitude)
      self.longitude = self.exif_data.try(:gps).try(:longitude)
      self.image_height = self.exif_data.height
      self.image_length = self.exif_data.width
  end

  # @image.exif_data.date_time for example (in not nil or error will happen)
  
end

