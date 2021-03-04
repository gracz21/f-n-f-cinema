# frozen_string_literal: true

module API
  module V1
    module Movies
      class Show < Grape::API
        desc '[Public] Show given movie',
             success: { code: 200, message: 'Movie found and returned' },
             failure: [
               { code: 404, message: 'Movie not found' }
             ]

        get do
          skip_authorization

          ::Movies::ShowSerializer.new(movie)
        end
      end
    end
  end
end
