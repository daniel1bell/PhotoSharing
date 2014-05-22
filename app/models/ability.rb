class Ability
 include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? != nil #so they are NOT just a visitor
      can :read, :all
      can :manage, Album do |album|
        album.user == user
      end
      can :manage, Picture do |picture|
        picture.album.user == user
      end
      can :destroy, Comment, album: {user_id: user.id}
      can :destroy, Comment, picture: {user_id: user.id} 
      can :manage, User do |thing|
        thing.id == user.id
      end
    elsif user.persisted?
      can :create, Comment
    elsif user.role? 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, User
    end
  end
end