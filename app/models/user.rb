class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter, :facebook]
  # Setup accessible (or protected) attributes for your model
  
  attr_accessible :bio, :profile_pic, :role, :url, :user_name, :email, :password, :password_confirmation, :remember_me, :uid, :provider
  
  has_many :albums , dependent: :destroy
  has_many :pictures, through: :albums

  validates :user_name, presence: true, uniqueness: true

  acts_as_tagger
  acts_as_voter

  mount_uploader :profile_pic, PictureImageUploader

  scope :most_recent, where("users.created_at >= ?", 1.day.ago.utc).order("users.created_at DESC")

  def self.from_omniauth(auth)
    twitter_email = if auth.info.nickname then auth.info.nickname.downcase + "@twitter.com" end
     
    if user = User.find_by_email(auth.info.email) || user = User.find_by_email(twitter_email) 
      user.provider = auth.provider
      user.uid = auth.uid
      user.profile_pic = auth.info.image
      user
    else
      
      if auth.provider == "twitter"
          test = User.create({
              :provider => auth.provider,
              :uid => auth.uid,
              :email => auth.info.nickname.downcase + "@twitter.com",
              :profile_pic => auth.info.image, # comes in small
              :password => Devise.friendly_token[0,20]
          })
          
      else
        where(auth.slice(:provider, :uid)).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.profile_pic = auth.info.image # comes in small
            user.password = Devise.friendly_token[0,20]
        end
      end 
    end
  end

  def self.most_liked
    # might change this method to database query later on - as it does a lot of queries 
    all.select{|u| u.total_likes > 0}.sort_by(&:total_likes).reverse
  end

  def self.most_commented
    all.select{|u| u.total_comments > 0}.sort_by(&:total_comments).reverse
  end

  def album_comments
    # make like table in the long-run to avoid this immense database queries
    if albums.any?
      album_comments = albums.select { |album| album.comments.count > 0}
      album_comments.count    
    else
      0
    end
  end

  def picture_comments
    # make like table in the long-run to avoid this immense database queries
    if pictures.any?
      pictures_comments = pictures.select { |picture| picture.comments.count > 0}
      pictures_comments.count    
    else
      0
    end
  end

  def total_comments
    picture_comments + album_comments
  end

  def album_likes
    # make like table in the long-run to avoid this immense database queries
    if albums.any?
      album_likes = []
      albums.each {|album| album_likes << album.votes_for.up.count}
      album_likes.inject{ |sum, x| sum + x}
    else
      0
    end
  end

  def photo_likes
    # make like table in the long-run to avoid this immense database queries
    if pictures.any?
      photo_likes = []
      albums.each do |album|
        if album.pictures.any?
          photo_likes << album.cumulative_likes
        else 0
        end
      end
      photo_likes.inject{ |sum, x| sum + x}
    else
      0
    end
  end

  def total_likes
    photo_likes + album_likes
  end
end
