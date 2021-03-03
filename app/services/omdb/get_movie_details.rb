# frozen_string_literal: true

require 'net/http'

module Omdb
  class GetMovieDetails
    URL_BASE = 'http://www.omdbapi.com/'
    private_constant :URL_BASE

    def initialize(api_key = ENV['OMDB_API_KEY'])
      @api_key = api_key
    end

    def call(omdb_id)
      response = make_call(omdb_id)

      parse_response(response)
    end

    private

    attr_reader :api_key

    def make_call(omdb_id)
      uri = URI("#{URL_BASE}?apikey=#{api_key}&i=#{omdb_id}")

      Net::HTTP.get_response(uri)
    end

    def parse_response(response)
      parsed_body = JSON.parse(response.body)
      status = response.code

      if status == '200'
        handle_success_response(status, parsed_body)
      else
        handle_failure_response(status, parsed_body)
      end
    end

    def handle_success_response(status, body)
      {
        omdb_fetch_status: status,
        omdb_fetch_error: nil,
        name: body['Title'],
        description: body['Plot'],
        release_date: body['Released'],
        imdb_rating: body['imdbRating'],
        runtime: body['Runtime']
      }
    end

    def handle_failure_response(status, body)
      {
        omdb_fetch_status: status,
        omdb_fetch_error: body['Error']
      }
    end
  end
end
