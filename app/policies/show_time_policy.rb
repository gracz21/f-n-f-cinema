# frozen_string_literal: true

class ShowTimePolicy < ApplicationPolicy
  def create?
    cinema_worker?(user)
  end

  def destroy?
    cinema_worker?(user)
  end

  private

  def cinema_worker?(user)
    user.role?(UserRoles::CINEMA_WORKER)
  end
end
