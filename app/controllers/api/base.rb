# frozen_string_literal: true

module API
  class Base < Grape::API
    include Rescuers

    after { verify_authorized }

    helpers Helpers::AuthHelper
    helpers Helpers::ErrorHelper

    add_swagger_documentation(
      mount_path: '/docs',
      array_use_braces: true,
      info: {
        title: 'Fast and Furious Cinema API',
        description: 'To obtain the access token, use the login endpoint'
      },
      security_definitions: {
        jwt_token: {
          type: 'apiKey',
          name: 'Authorization',
          in: 'header'
        }
      }
    )
  end
end
