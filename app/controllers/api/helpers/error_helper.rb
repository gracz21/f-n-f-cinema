# frozen_string_literal: true

module API
  module Helpers
    # Includes some basic methods used for proper representation of app-level exceptions
    # in a form of HTTP errors with JSON API compliant format
    module ErrorHelper
      extend ::Grape::API::Helpers

      def render_json_api_error(status:, title:, description:)
        error!(
          {
            errors: [{
              status: status,
              title: title,
              description: description
            }]
          },
          status
        )
      end

      def validation_error_description(error)
        error.validation_errors
      end

      def not_found_description(error)
        "Could not found #{error.model.underscore.humanize.downcase}"
      end
    end
  end
end
