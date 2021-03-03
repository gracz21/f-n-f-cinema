# frozen_string_literal: true

require 'rails_helper'

describe Omdb::GetMovieDetails, type: :service do
  subject(:service) { described_class.new(api_key) }

  describe '#call' do
    subject(:call) { service.call(omdb_id) }

    let(:omdb_id) { 'tt0232500' }

    describe 'success API call example' do
      let(:api_key) { 'some_valid_api_key' }

      let(:expected_response) do
        {
          omdb_fetch_status: '200',
          omdb_fetch_error: nil,
          name: 'The Fast and the Furious',
          description:
           "Los Angeles police officer Brian O'Conner must decide where his loyalty really lies when he becomes "\
           'enamored with the street racing world he has been sent undercover to destroy.',
          release_date: '22 Jun 2001',
          imdb_rating: '6.8',
          runtime: '106 min'
        }
      end

      it 'returns properly parsed response' do
        VCR.use_cassette('omdb_get_movie_details_success') do
          call
          expect(call).to eq(expected_response)
        end
      end
    end

    describe 'failure API call example - invalid API key' do
      let(:api_key) { 'some_invalid_api_key' }

      let(:expected_response) do
        {
          omdb_fetch_status: '401',
          omdb_fetch_error: 'Invalid API key!'
        }
      end

      it 'returns status and error' do
        VCR.use_cassette('omdb_get_movie_details_invalid_api_key') do
          call
          expect(call).to eq(expected_response)
        end
      end
    end
  end
end
