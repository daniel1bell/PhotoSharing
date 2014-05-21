class PicturesController < ApplicationController

# basic picture controller - still needs to be connected with User, Photo & Comment Controller
  before_filter :authenticate_user!
  before_filter :load_album, except: :search

# both tagging and search functionality for tags is working if you comment out load_album 
# we still have to fix the routes here (error message: no album id) and make the views awesome

  def search
    if params[:tag]
      @pictures = Picture.tagged_with(params[:tag])
    elsif params[:search] 
      @pictures = Picture.tagged_with(params[:search])
    else 
      redirect_to albums_path and return
    end
    render "index"
  end

  def index
    @pictures = @album.pictures.all

    respond_to do |format|
      format.js
      format.html 
    end
  end

  def new
    @picture = @album.pictures.build
  end

  def create 
    @picture = @album.pictures.new(params[:picture])

    respond_to do |format|
      if @picture.save
        format.html { redirect_to album_picture_path(@album, @picture), notice: 'Picture was successfully created.' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def show
    @picture = @album.pictures.find(params[:id])
    @comment = @picture.comments.new

    respond_to do |format|
      format.js
      format.html 
    end
  end

  def destroy
    @picture = @album.pictures.find(params[:id])
    @picture.destroy
    redirect_to(albums_path)
  end

  def edit
    @picture = @album.pictures.find(params[:id])
  end

  def update
    @picture = @album.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
      format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
      else
      format.html { render action: "edit" }
      end
    end
  end

  def like
    @picture = Picture.find(params[:id])
    @like = @picture.liked_by current_user 

    redirect_to @picture, notice: "Liked!"
  end

  def dislike
    @picture = Picture.find(params[:id])
    @dislike = @picture.downvote_from current_user

    redirect_to @picture, notice: "Unliked!"
  end

  private
  def load_album
    @album = Album.find(params[:album_id])
  end
end