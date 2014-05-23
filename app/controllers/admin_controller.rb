class AdminController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
    @flagged_pictures = MakeFlaggable::Flagging.where(flaggable_type: "Picture")
    @flagged_comments = MakeFlaggable::Flagging.where(flaggable_type: "Comment")
  end

end