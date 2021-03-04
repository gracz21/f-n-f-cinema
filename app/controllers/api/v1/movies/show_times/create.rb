# frozen_string_literal: true

module API
  module V1
    module Movies
      module ShowTimes
        class Create < Grape::API
          desc '[Cinema worker only] Create a new movie show time',
               success: { code: 201, message: 'Show time created successfully' },
               failure: [
                 { code: 401, message: 'User is not authenticated' },
                 { code: 403, message: 'User is not authorized to create a show time' },
                 { code: 404, message: 'Movie to update not found' },
                 { code: 422, message: 'Invalid params' }
               ]

          params do
            requires :start_time, type: Time
            requires :end_time, type: Time
          end

          before { authenticate_user! }

          post do
            authorize ShowTime, :create?
            show_time_data = {
              start_time: permitted_params[:start_time],
              end_time: permitted_params[:end_time],
              movie: movie
            }

            ::ShowTimes::CreateValidator.new.validate(show_time_data)
            ShowTimeSerializer.new(
              ShowTime.create!(show_time_data)
            )
          end
        end
      end
    end
  end
end
