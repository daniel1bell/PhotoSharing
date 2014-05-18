class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :albums
  has_many :pictures

  attr_accessible :bio, :profile_pic, :role, :url, :user_name

<<<<<<< HEAD

  def self.find_for_facebook_oauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.uid = auth.uid
     user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.remote_avatar_url = auth[:info][:image]
        puts "auth.info.name: "+auth.info.name  
        puts "remote_avatar_url: "+auth[:info][:image]       
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
=======
  acts_as_tagger
>>>>>>> act_as_taggable
end
