class Picture < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
<<<<<<< HEAD
  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation, :picture_image, :tag_list
  mount_uploader :picture_image

=======
  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation

  acts_as_taggable
  
>>>>>>> act_as_taggable
end

