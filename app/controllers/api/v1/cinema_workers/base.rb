# frozen_string_literal: true

module API
  module V1
    module CinemaWorkers
      class Base < Grape::API
        namespace :cinema_workers do
          before { authenticate_user! }

          mount Create
        end
      end
    end
  end
end
