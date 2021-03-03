# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Movies::Create, type: :request do
  subject(:call) { post endpoint, params: params, headers: auth_header(token) }

  let(:endpoint) { '/api/v1/movies' }
  let(:params) do
    {
      'omdb_id' => omdb_id,
      'price' => price
    }
  end

  let(:omdb_id) { 'tt0232500' }
  let(:price) { 15.0 }

  context 'when not authenticated' do
    let(:token) { nil }

    it 'responds with 401 status' do
      call
      expect(response).to have_http_status(401)
    end
  end

  context 'with authenticated user' do
    include_context 'with authenticated user'

    let(:current_user_email) { 'existing_user@example.com' }
    let(:current_user_password) { 'Password123' }

    before do
      User.create!(email: current_user_email, password: current_user_password, is_cinema_worker: is_cinema_worker)
    end

    context 'when not authorized' do
      let(:is_cinema_worker) { false }

      it 'responds with 403 status' do
        call
        expect(response).to have_http_status(403)
      end
    end

    context 'when authorized' do
      let(:is_cinema_worker) { true }
      let(:new_movie) { Movie.last }

      let(:expected_response) do
        {
          'data' => {
            'id' => new_movie.id.to_s,
            'type' => 'movie',
            'attributes' => {
              'omdb_id' => omdb_id,
              'price' => price
            }
          }
        }
      end

      it 'responds with 201 status' do
        call
        expect(response).to have_http_status(201)
      end

      it 'creates a new movie' do
        expect { call }.to change(Movie, :count).by(1)
      end

      it 'creates a new movie with given params' do
        call
        expect(new_movie.attributes).to include(params)
      end

      it 'returns new movie data serialized to JSON' do
        call
        expect(JSON.parse(response.body)).to match(expected_response)
      end

      it 'schedules a job to fetch movie details' do
        expect { call }.to have_enqueued_job(Movies::UpdateDetailsJob)
      end

      context 'with invalid params' do
        before { Movie.create!(omdb_id: omdb_id) }

        it 'responds with 422 status' do
          call
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
