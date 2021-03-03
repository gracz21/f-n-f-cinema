# frozen_string_literal: true

module Movies
  class CreateSerializer < ApplicationSerializer
    set_type :movie

    attributes :omdb_id, :price
  end
end
