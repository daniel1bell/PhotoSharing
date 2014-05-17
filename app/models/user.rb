class User < ActiveRecord::Base
  has_many :albums
  has_many :pictures

  attr_accessible :bio, :profile_pic, :role, :url, :user_name
end
