class UserPolicy < ApplicationPolicy
  attr_reader :user, :user

  def update?
    user == record.user
  end
end
