# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Movies::Create, type: :request do
  subject(:call) { post endpoint, params: params, headers: auth_header(token) }

  let(:endpoint) { "/api/v1/movies/#{movie_id}/ratings" }
  let(:movie) { Movie.create(overall_ratings_sum: 0, overall_ratings_count: 0) }
  let(:movie_id) { movie.id }
  let(:params) do
    {
      rating: rating
    }
  end

  let(:rating) { 3 }

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

    let!(:user) do
      User.create!(email: current_user_email, password: current_user_password, is_cinema_worker: is_cinema_worker)
    end

    context 'when not authorized' do
      let(:is_cinema_worker) { true }

      it 'responds with 403 status' do
        call
        expect(response).to have_http_status(403)
      end
    end

    context 'when authorized' do
      let(:is_cinema_worker) { false }
      let(:new_movie_rating) { MovieRating.last }

      let(:expected_params) do
        {
          'user_id' => user.id,
          'movie_id' => movie.id,
          'rating' => rating
        }
      end

      it 'responds with 201 status' do
        call
        expect(response).to have_http_status(201)
      end

      it 'creates a new movie rating' do
        expect { call }.to change(MovieRating, :count).by(1)
      end

      it 'creates a new movie with expected params' do
        call
        expect(new_movie_rating.attributes).to include(expected_params)
      end

      context 'with non-existing movie ID' do
        let(:movie_id) { movie.id + 1 }

        it 'responds with 404 status' do
          call
          expect(response).to have_http_status(404)
        end
      end

      context 'with invalid params' do
        before { MovieRating.create!(movie: movie, creator: user) }

        it 'responds with 422 status' do
          call
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
