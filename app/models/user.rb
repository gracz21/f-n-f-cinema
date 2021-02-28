# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable,
         :recoverable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
end
