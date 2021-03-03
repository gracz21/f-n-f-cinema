# frozen_string_literal: true

module API
  module V1
    module Movies
      class Base < Grape::API
        namespace :movies do
          mount Create
        end
      end
    end
  end
end
