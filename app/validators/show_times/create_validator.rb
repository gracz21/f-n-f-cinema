# frozen_string_literal: true

module ShowTimes
  class CreateValidator < ApplicationValidator
    params do
      required(:start_time).filled(:time)
      required(:end_time).filled(:time)
      required(:movie).filled(type?: Movie)
    end

    rule(:start_time) do
      key.failure('must be in future') if value <= Time.current
    end

    rule(:start_time, :end_time) do
      key.failure('must be before end_time') if values[:start_time] > values[:end_time]
    end

    # Assumption: a cinema have only one hall (could only play one movie at a time)
    rule(:start_time, :end_time) do
      if ShowTime.exists?(['start_time <= ? AND ? <= end_time', values[:end_time], values[:start_time]])
        key.failure('collides with existing show times')
      end
    end
  end
end
