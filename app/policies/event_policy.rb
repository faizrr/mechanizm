class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def owned?
    user == record.user
  end
end
