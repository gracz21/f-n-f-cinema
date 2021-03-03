# frozen_string_literal: true

module Movies
  class CreateValidator < ApplicationValidator
    params do
      required(:omdb_id).filled(:string)
      required(:price).filled(:float)
    end

    rule(:omdb_id) do
      key.failure('is already existing') if Movie.exists?(omdb_id: value)
    end
  end
end
