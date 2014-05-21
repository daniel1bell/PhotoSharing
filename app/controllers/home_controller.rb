class HomeController < ApplicationController

  def index
    @recent_albums = Album.most_recent

    @popular_albums = []
      @popular_albums << Album.most_liked
      @popular_albums << Album.most_commented
    @trending_albums = []
      @trending_albums << Album.most_liked
      @trending_albums << Album.most_commented
      @trending_albums << Album.most_recent

  end



end