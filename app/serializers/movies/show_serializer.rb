# frozen_string_literal: true

module Movies
  class ShowSerializer < ApplicationSerializer
    set_type :movie

    attributes :omdb_id,
               :price,
               :name,
               :description,
               :release_date,
               :imdb_rating,
               :runtime

    attribute :rating do |obj|
      obj.overall_ratings_count.zero? ? 0.0 : (obj.overall_ratings_sum.to_f / obj.overall_ratings_count).round(2)
    end
  end
end
