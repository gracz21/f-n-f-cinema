# frozen_string_literal: true

module API
  module V1
    module CinemaWorkers
      class Create < Grape::API
        desc '[Cinema worker only] Create a new cinema worker',
             success: { code: 201, message: 'Cinema worker created successfully' },
             failure: [
               { code: 401, message: 'User is not authenticated' },
               { code: 403, message: 'User is not authorized to create a cinema worker' },
               { code: 422, message: 'Invalid params' }
             ]

        params do
          requires :first_name, type: String
          requires :last_name, type: String
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, type: String
        end

        post do
          authorize User, :create?, policy_class: CinemaWorkerPolicy

          ::Users::CreateValidator.new.validate(permitted_params)

          UserSerializer.new(
            User.create!(permitted_params.merge(is_cinema_worker: true))
          )
        end
      end
    end
  end
end
