class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "owner"
      can :create, Scheme
      can :edit, Scheme do |s|
        s.user_id == user.id
      end
      can :create, Rating
      can :manage, Element
      cannot [:edit, :destroy], User
    elsif user.role == "visitor"
      cannot :create, Element
      can :create, Rating
      can :create, Scheme
      can :edit, Scheme do |s|
        s.user_id == user.id
      end
      cannot :manage, Element
      cannot [:edit, :destroy], User
      can :read, :all
    else
      can :read, :all
      cannot :update, :all
    end
  end

end
