# frozen_string_literal: true

module API
  module V1
    module Movies
      class Update < Grape::API
        desc '[Cinema worker only] Updates given movie',
             success: { code: 204, message: 'Movie updated' },
             failure: [
               { code: 401, message: 'User is not authenticated' },
               { code: 403, message: 'User is not authorized to create a movie' },
               { code: 404, message: 'Movie to update not found' },
               { code: 422, message: 'Invalid params' }
             ]

        params do
          optional :price, type: Float
        end

        before { authenticate_user! }

        patch do
          authorize movie, :update?

          ::Movies::UpdateValidator.new.validate(permitted_params)
          movie.update!(permitted_params)

          status :no_content
        end
      end
    end
  end
end
