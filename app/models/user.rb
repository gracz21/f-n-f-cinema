# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable,
         :recoverable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :ratings,
           class_name: 'MovieRating',
           foreign_key: :user_id,
           dependent: :destroy,
           inverse_of: :creator

  def role?(name)
    name == UserRoles::CINEMA_WORKER ? is_cinema_worker : false
  end
end
