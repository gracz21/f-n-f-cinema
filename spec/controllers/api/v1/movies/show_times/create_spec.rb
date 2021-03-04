# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Movies::ShowTimes::Create, type: :request do
  subject(:call) { post endpoint, params: params, headers: auth_header(token) }

  let(:endpoint) { "/api/v1/movies/#{movie_id}/show_times" }
  let(:movie_id) { movie.id }
  let(:movie) { Movie.create! }

  let(:params) do
    {
      'start_time' => start_time,
      'end_time' => end_time
    }
  end
  let(:start_time) { Time.current + 1.day }
  let(:end_time) { start_time + 1.hour }

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
      let(:new_show_time) { ShowTime.last }

      let(:expected_params) do
        {
          'movie_id' => movie.id,
          'start_time' => start_time.change(usec: 0),
          'end_time' => end_time.change(usec: 0)
        }
      end

      let(:expected_response) do
        {
          'data' => {
            'id' => new_show_time.id.to_s,
            'type' => 'show_time',
            'attributes' => {
              'start_time' => start_time.change(usec: 0),
              'end_time' => end_time.change(usec: 0)
            }
          }
        }
      end

      it 'responds with 201 status' do
        call
        expect(response).to have_http_status(201)
      end

      it 'creates a new show time record' do
        expect { call }.to change(ShowTime, :count).by(1)
      end

      it 'creates a new show time with expected params' do
        call
        expect(new_show_time.attributes).to include(expected_params)
      end

      it 'returns a new show time data serialized to JSON' do
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

      context 'with invalid params' do
        before { ShowTime.create!(movie: movie, start_time: start_time - 1.hour, end_time: start_time + 2.hours) }

        it 'responds with 422 status' do
          call
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
