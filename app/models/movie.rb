# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :ratings,
           class_name: 'MovieRating',
           foreign_key: :movie_id,
           dependent: :destroy,
           inverse_of: :movie
  has_many :show_times, dependent: :destroy
end
