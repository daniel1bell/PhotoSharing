class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create 
    @comment = @picture.comment.new(params[:comment])

    if @comment.save
      redirect_to album_picture_path(@album, @picture)
    end
  end

  def load_picture
    @picture = Picture.find(params[:picture_id])
  end

  def load_album
    @album = Album.find(params[:album_id])
  end

end