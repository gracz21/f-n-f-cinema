# frozen_string_literal: true

module MovieRatings
  class CreateValidator < ApplicationValidator
    params do
      required(:rating).filled(:float)
      required(:creator).filled(type?: User)
      required(:movie).filled(type?: Movie)
    end

    rule(:rating) do
      key.failure('has to be from 1-5 range') unless (1..5).include?(value)
    end

    rule(:movie, :creator) do
      key.failure('was already rated') if MovieRating.exists?(movie: values[:movie], creator: values[:creator])
    end
  end
end
