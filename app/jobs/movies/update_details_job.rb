# frozen_string_literal: true

module Movies
  class UpdateDetailsJob < ApplicationJob
    def perform(movie)
      UpdateDetails.new.call(movie)
    end
  end
end
