# frozen_string_literal: true

module Movies
  class UpdateValidator < ApplicationValidator
    params do
      optional(:price).filled(:float)
    end
  end
end
