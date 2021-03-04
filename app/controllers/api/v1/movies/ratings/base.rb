# frozen_string_literal: true

module API
  module V1
    module Movies
      module Ratings
        class Base < Grape::API
          namespace :ratings do
            mount Create
          end
        end
      end
    end
  end
end
