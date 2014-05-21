class HomeController < ApplicationController

  def index
    @recent_albums = []
      @recent_albums << Album.most_recent.limit(2)

    @popular_albums = []
      @popular_albums << Album.most_liked
      @popular_albums << Album.most_commented
    @trending_albums = []
      @trending_albums << Album.most_liked
      @trending_albums << Album.most_commented
      @trending_albums << Album.most_recent

    @recent_pictures = []
      @recent_pictures << Picture.most_recent.limit(2)

    @popular_pictures = []
      @popular_pictures << Picture.most_liked
      @popular_pictures << Picture.most_commented
    @trending_pictures = []
      @trending_pictures << Picture.most_liked
      @trending_pictures << Picture.most_commented
      @trending_pictures << Picture.most_recent
  end



end