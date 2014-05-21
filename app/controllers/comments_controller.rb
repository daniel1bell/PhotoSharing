class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_album
  before_filter :load_picture

  def create 
    if params[:comment][:commentable_type] == "Album"
      @comment = @album.comments.build(params[:comment])

      if @comment.save
        redirect_to album_path(@album)
      end
    else
      @comment = @picture.comments.build(params[:comment])

      if @comment.save
        redirect_to album_picture_path(@album, @picture)
      end
    end
  end

  def load_picture
    if params[:picture_id]
      @picture = Picture.find(params[:picture_id])
    end
  end

  def load_album
    @album = Album.find(params[:album_id])
  end

end