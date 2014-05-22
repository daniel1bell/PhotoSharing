class HomeController < ApplicationController

  def index
    @recent_albums = Album.most_recent.limit(6)
    @popular_albums = Album.most_liked + Album.most_commented
    @trending_albums = Album.most_liked + Album.most_commented + Album.most_recent

    @recent_pictures = Picture.most_recent.limit(6)
    @popular_pictures = Picture.most_liked + Picture.most_commented
    @trending_pictures = Picture.most_liked + Picture.most_commented + Picture.most_recent

    @recent_users = User.most_recent.limit(4)
    @popular_users = User.most_liked + User.most_commented
    @trending_users = User.most_liked + User.most_commented + User.most_recent

  end

end