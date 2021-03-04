# frozen_string_literal: true

class ShowTimeFilter
  def initialize(scope = ShowTime.all)
    @scope = scope
  end

  def call(filters = {})
    filter_by_date(filters&.dig(:show_date))

    scope
  end

  private

  attr_reader :scope

  def filter_by_date(show_date)
    return if show_date.nil?

    @scope = scope.where(start_time: show_date.beginning_of_day..show_date.end_of_day)
  end
end
