# frozen_string_literal: true

class MoviePolicy < ApplicationPolicy
  def create?
    cinema_worker?(user)
  end

  def update?
    cinema_worker?(user)
  end

  private

  def cinema_worker?(user)
    user.role?(UserRoles::CINEMA_WORKER)
  end
end
