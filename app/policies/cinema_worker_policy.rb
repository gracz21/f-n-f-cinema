# frozen_string_literal: true

class CinemaWorkerPolicy < ApplicationPolicy
  def create?
    user&.role?(UserRoles::CINEMA_WORKER)
  end
end
