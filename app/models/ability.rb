class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # account for users not logged in

    case user.role.name
    when 'gsa'
      can :manage, :all
      cannot :destroy, Social

    when 'implementor'
      can [:read, :update, :create], Social
      can :read, User

    when 'builder'
      can :read, Social
      can :read, User

    when 'guest'
      can :read, Social, id: 1..10
      can [:read, :update], User, id: user.id
    end
  end
end
