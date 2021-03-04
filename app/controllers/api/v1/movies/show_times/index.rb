# frozen_string_literal: true

module API
  module V1
    module Movies
      module ShowTimes
        class Index < Grape::API
          desc '[Public] List show times for given movie',
               success: { code: 200, message: 'Show times returned' },
               failure: [
                 { code: 404, message: 'Movie not found' },
                 { code: 422, message: 'Invalid params' }
               ]

          params do
            optional :filters, type: Hash do
              optional :show_date, type: Date
            end
          end

          get do
            skip_authorization

            ShowTimeSerializer.new(
              ShowTimeFilter.new(movie.show_times).call(permitted_params[:filters]).order(:start_time)
            )
          end
        end
      end
    end
  end
end
