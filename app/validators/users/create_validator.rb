# frozen_string_literal: true

module Users
  class CreateValidator < ApplicationValidator
    params do
      required(:first_name).filled(:string)
      required(:last_name).filled(:string)
      required(:email).filled(:string)
      required(:password).filled(:string)
      required(:password_confirmation).filled(:string)
    end

    rule(:email) do
      key.failure('is already used') if User.exists?(email: value)
    end

    rule(:email) do
      key.failure('has invalid format') unless Devise.email_regexp.match?(value)
    end

    rule(:password_confirmation, :password) do
      key.failure('must match password') if values[:password] != values[:password_confirmation]
    end
  end
end
