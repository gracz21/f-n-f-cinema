# frozen_string_literal: true

module API
  module V1
    module Movies
      class Base < Grape::API
        namespace :movies do
          mount Create

          route_param :id, type: Integer do
            helpers do
              def movie
                @movie ||= Movie.find(params[:id])
              end
            end

            mount Update
          end
        end
      end
    end
  end
end
