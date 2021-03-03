# frozen_string_literal: true

module API
  module Rescuers
    extend ActiveSupport::Concern

    included do
      rescue_from UnauthenticatedError do
        render_json_api_error(
          status: 401,
          title: 'Not authenticated',
          description: 'Not authenticated, authenticate and try again'
        )
      end

      rescue_from Pundit::NotAuthorizedError do
        render_json_api_error(
          status: 403,
          title: 'Not authorized',
          description: 'You are not authorized to perform this action'
        )
      end

      rescue_from ActiveRecord::RecordNotFound do |error|
        render_json_api_error(
          status: 404,
          title: 'Record Not Found',
          description: not_found_description(error)
        )
      end

      rescue_from ValidationError, Grape::Exceptions::ValidationErrors do |error|
        render_json_api_error(
          status: 422,
          title: 'Invalid payload',
          description: validation_error_description(error)
        )
      end

      rescue_from :all do
        render_json_api_error(
          status: 500,
          title: 'Internal server error',
          description: 'Something went wrong, please try again later'
        )
      end
    end
  end
end
