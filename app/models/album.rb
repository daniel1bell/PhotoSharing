class Album < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name

  acts_as_taggable

end
