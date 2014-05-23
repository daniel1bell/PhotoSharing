class AdminController < ApplicationController

  def index
    @users = User.all
    @flagged_pictures = MakeFlaggable::Flagging.where(flaggable_type: "Picture")
    @flagged_comments = MakeFlaggable::Flagging.where(flaggable_type: "Comment")
  end

end