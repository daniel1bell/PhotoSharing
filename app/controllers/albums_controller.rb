class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @albums = Album.where(user_id: current_user.id)
  end

  def new
    @album = Album.new
  end

  def create 
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def show
    @album = Album.find(params[:id])
    @comment = @album.comments.new
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to(albums_path)
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
      format.html { redirect_to @album, notice: 'Album was successfully updated.' }
      else
      format.html { render action: "edit" }
      end
    end
  end

  def search
    index
    render :index
  end

  def like
    @album = Album.find(params[:id])
    @like = @album.liked_by current_user 

    redirect_to @album, notice: "Liked!"
  end

  def dislike
    @album = Album.find(params[:id])
    @dislike = @album.downvote_from current_user

    redirect_to @album, notice: "Unliked!"
  end

end