# frozen_string_literal: true

module API
  module V1
    module Movies
      module ShowTimes
        class Base < Grape::API
          namespace :show_times do
            mount Create
            mount Index
          end
        end
      end
    end
  end
end
