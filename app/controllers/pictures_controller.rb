class PicturesController < ApplicationController

# basic picture controller - still needs to be connected with User, Photo & Comment Controller

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create 
    @picture = Picture.new(params[:picture])

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to(pictures_path)
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
      format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
      else
      format.html { render action: "edit" }
      end
    end
  end


end