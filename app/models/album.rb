class Album < ActiveRecord::Base
  belongs_to :user

  attr_accessible :description, :name

  acts_as_taggable
  acts_as_votable
  acts_as_commentable

end
