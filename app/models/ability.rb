# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.role == 'school'
      can :manage, :school_dashboard
    else
      can :read, :home
      cannot :manage, :school_dashboard
    end
  end
end
