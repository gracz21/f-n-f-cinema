# frozen_string_literal: true

module Movies
  class UpdateDetails
    def initialize(get_movie_details_service = Omdb::GetMovieDetails.new)
      @get_movie_details_service = get_movie_details_service
    end

    def call(movie)
      response = get_movie_details_service.call(movie.omdb_id)
      movie.update!(response)
    end

    private

    attr_reader :get_movie_details_service
  end
end
