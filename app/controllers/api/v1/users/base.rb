# frozen_string_literal: true

module API
  module V1
    module Users
      class Base < Grape::API
        namespace :users do
          mount Create
        end
      end
    end
  end
end
