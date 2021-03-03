# frozen_string_literal: true

class AddOverallRatingsSumAndOverallRatingsCountToMovie < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :overall_ratings_sum, :integer
    add_column :movies, :overall_ratings_count, :integer
  end
end
