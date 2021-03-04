# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Movies::Show, type: :request do
  subject(:call) { get endpoint }

  let(:endpoint) { "/api/v1/movies/#{movie_id}" }
  let(:movie_id) { movie.id }

  let(:movie) do
    Movie.create!(
      omdb_id: omdb_id,
      price: price,
      name: name,
      description: description,
      release_date: release_date,
      imdb_rating: imdb_rating,
      runtime: runtime,
      overall_ratings_count: 4,
      overall_ratings_sum: 9
    )
  end

  let(:omdb_id) { 'tt0232500' }
  let(:price) { 21.0 }
  let(:name) { 'Cool movie' }
  let(:description) { 'Some cool movie about cool dudes' }
  let(:release_date) { '3 Feb 2021' }
  let(:imdb_rating) { '7.43' }
  let(:runtime) { '130 min' }

  let(:expected_response) do
    {
      'data' => {
        'id' => movie.id.to_s,
        'type' => 'movie',
        'attributes' => {
          'omdb_id' => omdb_id,
          'price' => price,
          'name' => name,
          'description' => description,
          'release_date' => release_date,
          'imdb_rating' => imdb_rating,
          'runtime' => runtime,
          'rating' => 2.25
        }
      }
    }
  end

  it 'responds with 200 status' do
    call
    expect(response).to have_http_status(200)
  end

  it 'returns requested movie data serialized to JSON' do
    call
    expect(JSON.parse(response.body)).to match(expected_response)
  end

  context 'with non-existing movie ID' do
    let(:movie_id) { movie.id + 1 }

    it 'responds with 404 status' do
      call
      expect(response).to have_http_status(404)
    end
  end
end
