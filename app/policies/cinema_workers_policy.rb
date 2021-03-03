# frozen_string_literal: true

class CinemaWorkersPolicy < ApplicationPolicy
  def create?
    user&.role?(UserRoles::CINEMA_WORKER)
  end
end
