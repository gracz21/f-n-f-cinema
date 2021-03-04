# frozen_string_literal: true

module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path

      content_type :json, 'application/vnd.api+json'
      default_format :json

      # Verify Pundit policy was called (or skip_authorization was called explicitly)
      after { verify_authorized }

      mount CinemaWorkers::Base
      mount Movies::Base
      mount ShowTimes::Base
      mount Users::Base
    end
  end
end
