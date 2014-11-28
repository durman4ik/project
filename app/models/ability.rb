class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "owner"
      can :create, Comment
      can :destroy, Comment do |s|
        s.user_id == user.id
      end

      can :create, Scheme
      can :edit, Scheme do |s|
        s.user_id == user.id
      end
      can :destroy, Scheme do |s|
        s.user_id == user.id
      end

      can :create, Rating
      can :manage, Element
      cannot [:edit, :destroy], User
    elsif user.role == "user"
      can :create, Comment

      can :destroy, Comment do |s|
        s.user_id == user.id
      end

      can :create, Rating
      can :create, Scheme

      can :edit, Scheme do |s|
        s.user_id == user.id
      end

      can :destroy, Scheme do |s|
        s.user_id == user.id
      end

      cannot :manage, Element
      cannot [:edit, :destroy], User
    else
      can :read, :all
      cannot :create, :all
    end
  end

end
