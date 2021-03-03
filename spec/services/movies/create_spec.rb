# frozen_string_literal: true

require 'rails_helper'

describe Movies::Create, type: :service do
  subject(:service) { described_class.new(dummy_job_class) }

  let(:dummy_job_class) { class_double(Movies::UpdateDetailsJob, perform_later: true) }

  describe '#call' do
    subject(:call) { service.call(omdb_id: omdb_id, price: price) }

    let(:omdb_id) { 'tt0232500' }
    let(:price) { 15.00 }

    let(:new_movie) { Movie.last }

    it 'creates a new movie' do
      expect { call }.to change(Movie, :count).by(1)
    end

    it 'returns a new movie' do
      expect(call).to eq(new_movie)
    end

    it 'creates a movie with given params' do
      call
      expect(new_movie.attributes).to include('omdb_id' => omdb_id, 'price' => price)
    end

    it 'schedules a job to fetch movie details' do
      call
      expect(dummy_job_class).to have_received(:perform_later).with(new_movie)
    end
  end
end
