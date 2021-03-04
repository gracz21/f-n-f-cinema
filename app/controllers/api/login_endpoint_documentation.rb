# frozen_string_literal: true

module API
  # This endpoint is defined in Grape only for the Swagger documentation purpose.
  # While calling '/login' the Devise '/login' endpoint will be called.
  class LoginEndpointDocumentation < Grape::API
    desc 'Request for an api key',
         success: { code: 201, message: 'User authenticated' },
         failure: [
           {
             code: 401,
             message: 'Invalid authentication data'
           }
         ]

    params do
      requires :user, type: Hash do
        requires :email, type: String
        requires :password, type: String, documentation: { type: :password }
      end
    end

    post :login do
      raise NotImplementedError
    end
  end
end
