# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Movies::Update, type: :request do
  subject(:call) { patch endpoint, params: params, headers: auth_header(token) }

  let(:endpoint) { "/api/v1/movies/#{movie_id}" }
  let(:params) do
    {
      'price' => price
    }
  end
  let(:movie_id) { movie.id }
  let(:movie) { Movie.create!(price: 20.0) }

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

      it 'responds with 204 status' do
        call
        expect(response).to have_http_status(204)
      end

      it 'updates the movie with given params' do
        call
        expect(movie.reload.attributes).to include(params)
      end

      context 'with non-existing movie ID' do
        let(:movie_id) { movie.id + 1 }

        it 'responds with 404 status' do
          call
          expect(response).to have_http_status(404)
        end
      end

      context 'with invalid params' do
        let(:price) { nil }

        it 'responds with 422 status' do
          call
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
