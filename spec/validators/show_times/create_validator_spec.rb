# frozen_string_literal: true

require 'rails_helper'

describe ShowTimes::CreateValidator, type: :validator do
  subject(:validator) { described_class.new }

  describe '#validate' do
    subject(:validate) { validator.validate(params) }

    let(:params) do
      {
        movie: movie,
        start_time: start_time,
        end_time: end_time
      }
    end

    let(:movie) { Movie.create! }
    let(:start_time) { Time.current + 1.day }
    let(:end_time) { start_time + 2.hours }

    it 'does not raise any validation errors' do
      expect { validate }.not_to raise_error
    end

    context 'with empty start time' do
      let(:start_time) { nil }
      let(:end_time) { Time.current }

      it_behaves_like 'failing validation'
    end

    context 'with empty end time' do
      let(:end_time) { nil }

      it_behaves_like 'failing validation'
    end

    context 'with end time before start time' do
      let(:end_time) { Time.current - 1.day }

      it_behaves_like 'failing validation'
    end

    context 'when given start and end times collides with existing show times' do
      before { ShowTime.create!(movie: movie, start_time: start_time - 1.hour, end_time: start_time + 2.hours) }

      it_behaves_like 'failing validation'
    end
  end
end
