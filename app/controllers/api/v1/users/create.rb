# frozen_string_literal: true

module API
  module V1
    module Users
      class Create < Grape::API
        desc 'Create a new user',
             success: { code: 201, message: 'User created successfully' },
             failure: [
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
          skip_authorization

          ::Users::CreateValidator.new.validate(permitted_params)

          UserSerializer.new(
            User.create!(permitted_params.merge(is_cinema_worker: false))
          )
        end
      end
    end
  end
end
