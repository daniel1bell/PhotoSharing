class Picture < ActiveRecord::Base
  belongs_to :album

  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation, :picture_image, :tag_list
  mount_uploader :picture_image, PictureImageUploader

  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation

  acts_as_taggable
  acts_as_votable
  acts_as_commentable

  PictureImageUploader

<<<<<<< HEAD

=======
  def user
    album.user
  end
  
>>>>>>> 738507de53baadf2203fcb69629ba70b2db59698
end

