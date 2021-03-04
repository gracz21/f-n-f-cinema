# frozen_string_literal: true

class MovieRating < ApplicationRecord
  belongs_to :movie
  belongs_to :creator, class_name: 'User', foreign_key: :user_id, inverse_of: :ratings
end
