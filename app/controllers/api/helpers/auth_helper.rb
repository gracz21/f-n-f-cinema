# frozen_string_literal: true

module API
  module Helpers
    # Includes some helper methods allowing Grape to integrate with authentication system (Devise + Warden)
    # and authorization system (Pundit)
    module AuthHelper
      extend ::Grape::API::Helpers
      include Pundit

      def current_user
        warden = env['warden']
        @current_user ||= warden.authenticate
      end

      def authenticate_user!
        raise UnauthenticatedError unless current_user.present?
      end
    end
  end
end
