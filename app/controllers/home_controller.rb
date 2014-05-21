class HomeController < ApplicationController

  def index
    @recent_albums = Album.most_recent.limit(4)

    @popular_albums = Album.most_popular.limit(4)

  end



end