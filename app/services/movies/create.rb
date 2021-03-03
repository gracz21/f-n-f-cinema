# frozen_string_literal: true

module Movies
  class Create
    def initialize(fetch_details_job = UpdateDetailsJob)
      @fetch_details_job = fetch_details_job
    end

    def call(omdb_id:, price:)
      movie = Movie.create!(omdb_id: omdb_id, price: price)
      fetch_details_job.perform_later(movie)

      movie
    end

    private

    attr_reader :fetch_details_job
  end
end
