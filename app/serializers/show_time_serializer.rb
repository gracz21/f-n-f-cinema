# frozen_string_literal: true

class ShowTimeSerializer < ApplicationSerializer
  set_type :show_time

  attributes :start_time, :end_time
end
