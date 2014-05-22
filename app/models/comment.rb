class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  belongs_to :commentable, :polymorphic => true

  attr_accessible :title, :comment, :user_id, :commentable_type

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  
  acts_as_votable
  make_flaggable :inappropriate

  # NOTE: Comments belong to a user
  belongs_to :user
end
