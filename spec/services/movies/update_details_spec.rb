# frozen_string_literal: true

require 'rails_helper'

describe Movies::UpdateDetails, type: :service do
  subject(:service) { described_class.new }

  describe '#call' do
    subject(:call) { service.call(movie) }

    let(:movie) { Movie.create!(omdb_id: 'tt0232500') }

    before { allow(ENV).to receive(:[]).with('OMDB_API_KEY').and_return(api_key) }

    describe 'successful details fetch case' do
      let(:api_key) { 'some_valid_api_key' }

      let(:expected_changes) do
        {
          'omdb_fetch_status' => 200,
          'omdb_fetch_error' => nil,
          'name' => 'The Fast and the Furious',
          'description' => "Los Angeles police officer Brian O'Conner must decide where his loyalty really "\
          'lies when he becomes enamored with the street racing world he has been sent undercover to destroy.',
          'release_date' => '22 Jun 2001',
          'imdb_rating' => '6.8',
          'runtime' => '106 min'
        }
      end

      it 'updates the movie details and OMDb fetch status' do
        VCR.use_cassette('omdb_get_movie_details_success') do
          call
          expect(movie.attributes).to include(expected_changes)
        end
      end
    end

    describe 'failure details fetch case - wrong API key' do
      let(:api_key) { 'some_invalid_api_key' }

      let(:expected_changes) do
        {
          'omdb_fetch_status' => 401,
          'omdb_fetch_error' => 'Invalid API key!'
        }
      end

      it 'updates the OMDb fetch status and the OMDb error' do
        VCR.use_cassette('omdb_get_movie_details_invalid_api_key') do
          call
          expect(movie.attributes).to include(expected_changes)
        end
      end
    end
  end
end
