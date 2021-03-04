# frozen_string_literal: true

class MovieRatingPolicy < ApplicationPolicy
  def create?
    !user.role?(UserRoles::CINEMA_WORKER)
  end
end
