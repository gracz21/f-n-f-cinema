# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Movies::ShowTimes::Index, type: :request do
  subject(:call) { get endpoint, params: params }

  let(:endpoint) { "/api/v1/movies/#{movie_id}/show_times" }
  let(:params) { {} }

  let(:movie_id) { movie.id }
  let(:movie) { Movie.create! }

  let!(:show_time1) do
    ShowTime.create(
      start_time: Time.current + 2.day,
      end_time: Time.current + 2.day + 2.hours,
      movie: movie
    )
  end
  let!(:show_time2) do
    ShowTime.create(
      start_time: Time.current + 1.day,
      end_time: Time.current + 1.day + 1.hours,
      movie: movie
    )
  end

  let(:expected_response) do
    {
      'data' =>
        [
          {
            'id' => show_time2.id.to_s,
            'type' => 'show_time',
            'attributes' => {
              'start_time' => show_time2.start_time.as_json,
              'end_time' => show_time2.end_time.as_json
            }
          },
          {
            'id' => show_time1.id.to_s,
            'type' => 'show_time',
            'attributes' => {
              'start_time' => show_time1.start_time.as_json,
              'end_time' => show_time1.end_time.as_json
            }
          }
        ]
    }
  end

  it 'responds with 200 status' do
    call
    expect(response).to have_http_status(200)
  end

  it 'returns all show times for requested movie in JSON format' do
    call
    expect(JSON.parse(response.body)).to match(expected_response)
  end

  context 'with filter params applied' do
    let(:params) do
      {
        filters: {
          show_date: Date.current + 1.day
        }
      }
    end

    let(:expected_response) do
      {
        'data' =>
          [
            {
              'id' => show_time2.id.to_s,
              'type' => 'show_time',
              'attributes' => {
                'start_time' => show_time2.start_time.as_json,
                'end_time' => show_time2.end_time.as_json
              }
            }
          ]
      }
    end

    it 'returns only records that match applied filters' do
      call
      expect(JSON.parse(response.body)).to match(expected_response)
    end
  end

  context 'with non-existing movie ID' do
    let(:movie_id) { movie.id + 1 }

    it 'responds with 404 status' do
      call
      expect(response).to have_http_status(404)
    end
  end
end
