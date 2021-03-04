# frozen_string_literaL: true

module API
  module V1
    module Movies
      module Ratings
        class Create < Grape::API
          desc '[Regular users only] Create a rating for given movue',
               success: { code: 201, message: 'Movie rating created successfully' },
               failure: [
                 { code: 401, message: 'User is not authenticated' },
                 { code: 403, message: 'User is not authorized to create a movie rating' },
                 { code: 404, message: 'Movie to rate not found' },
                 { code: 422, message: 'Invalid params' }
               ]

          params do
            requires :rating, type: Integer
          end

          before { authenticate_user! }

          post do
            authorize MovieRating, :create?

            movie_rating_data = {
              rating: permitted_params[:rating],
              creator: current_user,
              movie: movie
            }

            ::MovieRatings::CreateValidator.new.validate(movie_rating_data)
            ::MovieRatings::Create.new.call(movie_rating_data)

            status :created
          end
        end
      end
    end
  end
end
