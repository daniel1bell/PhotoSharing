class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter, :facebook]
  # Setup accessible (or protected) attributes for your model
  
  attr_accessible :bio, :profile_pic, :role, :url, :user_name, :email, :password, :password_confirmation, :remember_me, :uid, :provider
  
  has_many :albums , dependent: :destroy 

  acts_as_tagger
  acts_as_voter

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
              :profile_pic => auth.info.image,
              :password => Devise.friendly_token[0,20]
          })
          
      else
        where(auth.slice(:provider, :uid)).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.profile_pic = auth.info.image
            user.password = Devise.friendly_token[0,20]
        end
      end 
    end
  end



end
