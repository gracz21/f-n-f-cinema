# frozen_string_literal: true

module API
  module V1
    module ShowTimes
      class Base < Grape::API
        namespace :show_times do
          route_param :id, type: Integer do
            helpers do
              def show_time
                @show_time ||= ShowTime.find(params[:id])
              end
            end

            mount Destroy
          end
        end
      end
    end
  end
end
