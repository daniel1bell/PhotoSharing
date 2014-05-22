class Album < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, dependent: :destroy

  attr_accessible :description, :name, :user_id

  acts_as_taggable
  acts_as_votable
  acts_as_commentable
  make_flaggable :inappropriate

  scope :most_liked, select("albums.*, count(votes.id) as vote_count").joins("JOIN votes ON albums.id = votes.votable_id").group("albums.id").order("vote_count DESC")
  scope :most_commented, select("albums.*, count(comments.id) as comment_count").joins("JOIN comments ON albums.id = comments.commentable_id").group("albums.id").order("comment_count DESC")
  scope :most_recent, where("albums.created_at >= ?", 1.day.ago.utc).order("albums.created_at DESC")

  

  def ids
    arry = []
    pictures.each do |picture|
      arry << picture.id
    end
    return arry
  end

  def teaser_pic_generator
    if self.ids.count >= 4
      self.ids.sample(4)
    elsif self.ids.count == 3
      self.ids.sample(3)
    elsif self.ids.count == 2
      self.ids.sample(2)
    elsif self.ids.count == 1
      self.ids.sample(1)
    else
      []
    end
  end

  def teaser_pic(pic_arry, i)
    if pic_arry.count >= i
      return Picture.find(pic_arry[i-1]).picture_image.thumb
    else
      return ""
    end
  end

  def cumulative_likes
    picture_likes = []
    pictures.each {|picture| picture_likes << picture.votes_for.up.count}
    picture_likes.inject{ |sum, x| sum + x}
  end

end
