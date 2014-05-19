class AlbumsController < ApplicationController

# basic album controller - still needs to be connected with User, Photo & Comment Controller
  before_filter :authenticate_user!

  def index
      @albums = Album.all
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


end