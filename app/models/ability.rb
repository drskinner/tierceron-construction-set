class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # account for users not logged in

    case user.role.name
    when 'gsa'
      can :manage, :all
      cannot :destroy, Social

    when 'implementor'
      can %i[create read update], Item
      can :destroy, Item, vnum: user.owned_vnums
      can %i[read update create], Social
      can :read, User
      can :update, User, id: user.id
      can :read, Zone

    when 'builder'
      can %i[create read], Item
      can %i[update destroy], Item, vnum: user.owned_vnums
      can :read, Social
      can :read, User
      can :update, User, id: user.id
      can :read, Zone

    when 'guest'
      can :read, Item, vnum: 10200..10208
      can :read, Social, id: 1..10
      cannot :manage, User
      can :read, Zone
    end
  end
end
