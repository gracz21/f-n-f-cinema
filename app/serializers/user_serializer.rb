# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  set_type :user

  attributes :first_name, :last_name, :email
end
