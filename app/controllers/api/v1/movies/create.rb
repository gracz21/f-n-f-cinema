# frozen_string_literal: true

module API
  module V1
    module Movies
      class Create < Grape::API
        desc '[Cinema worker only] Create a new movie',
             success: { code: 201, message: 'Movie created successfully' },
             failure: [
               { code: 401, message: 'User is not authenticated' },
               { code: 403, message: 'User is not authorized to create a movie' },
               { code: 422, message: 'Invalid params' }
             ]

        params do
          requires :omdb_id, type: String
          requires :price, type: Float
        end

        before { authenticate_user! }

        post do
          authorize Movie, :create?

          ::Movies::CreateValidator.new.validate(permitted_params)

          ::Movies::CreateSerializer.new(
            ::Movies::Create.new.call(omdb_id: permitted_params[:omdb_id], price: permitted_params[:price])
          )
        end
      end
    end
  end
end
