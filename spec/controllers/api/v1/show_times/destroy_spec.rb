# frozen_string_literal: true

require 'rails_helper'

describe API::V1::ShowTimes::Destroy, type: :request do
  subject(:call) { delete endpoint, headers: auth_header(token) }

  let(:endpoint) { "/api/v1/show_times/#{show_time_id}" }
  let(:show_time_id) { show_time.id }

  let(:movie) { Movie.create! }
  let(:show_time) { ShowTime.create!(movie: movie) }

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

      it 'destroys requested show time' do
        expect { call }.to change { ShowTime.exists?(show_time_id) }.to(false)
      end

      context 'with non-existing movie ID' do
        let(:show_time_id) { show_time.id + 1 }

        it 'responds with 404 status' do
          call
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
