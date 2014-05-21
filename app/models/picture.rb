class Picture < ActiveRecord::Base
  belongs_to :album

  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation, :picture_image, :tag_list
  mount_uploader :picture_image, PictureImageUploader

  attr_accessible :altitude, :camera_make, :camera_model, :datetime, :exposure, :flash, :focal_length, :image, :image_height, :image_length, :latitude, :longitude, :name, :orientation

  acts_as_taggable
  acts_as_votable
  acts_as_commentable

  PictureImageUploader

  scope :most_liked, select("pictures.*, count(votes.id) as vote_count").joins("JOIN votes ON pictures.id = votes.votable_id").group("pictures.id").order("vote_count DESC")
  scope :most_commented, select("pictures.*, count(comments.id) as comment_count").joins("JOIN comments ON pictures.id = comments.commentable_id").group("pictures.id").order("comment_count DESC")
  scope :most_recent, where("pictures.created_at >= ?", 1.day.ago.utc).order("pictures.created_at DESC")

  def user
    album.user
  end
  
end

