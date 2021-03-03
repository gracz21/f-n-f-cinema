# frozen_string_literal: true

module MovieRatings
  class Create
    def call(movie:, rating:, creator:)
      movie_rating = nil

      ActiveRecord::Base.transaction do
        movie_rating = create_movie_rating(movie, rating, creator)
        update_movie_overall_rating(movie, rating)
      end

      movie_rating
    end

    private

    def create_movie_rating(movie, rating, creator)
      MovieRating.create!(movie: movie, rating: rating, creator: creator)
    end

    def update_movie_overall_rating(movie, rating)
      # Lock movie object on any updates as we need to read and increment the current values
      movie.lock!
      movie.update!(
        overall_ratings_count: movie.overall_ratings_count + 1,
        overall_ratings_sum: movie.overall_ratings_sum + rating
      )
    end
  end
end
