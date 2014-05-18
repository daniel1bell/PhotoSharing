class PicturesController < ApplicationController

# basic picture controller - still needs to be connected with User, Photo & Comment Controller
  before_filter :authenticate_user!, :load_album

  def index
    if params[:tag]
      @pictures = Picture.tagged_with(params[:tag])
    else
      @pictures = Picture.all
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

  private
  def load_album
    @album = Album.find(params[:album_id])
  end
end