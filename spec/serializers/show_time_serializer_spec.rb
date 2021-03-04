# frozen_string_literal: true

require 'rails_helper'

describe ShowTimeSerializer, type: :serializer do
  subject(:serializer) { described_class.new(show_time) }

  let(:show_time) do
    ShowTime.create!(
      movie: movie,
      start_time: start_time,
      end_time: end_time
    )
  end

  let(:movie) { Movie.create! }
  let(:start_time) { Time.current + 1.day }
  let(:end_time) { start_time + 2.hours }

  describe '#as_json' do
    subject(:as_json) { serializer.as_json }

    describe 'data' do
      subject(:data) { as_json['data'] }

      it 'contains correct type' do
        expect(data['type']).to eq('show_time')
      end

      it 'contains correct id' do
        expect(data['id']).to eq(show_time.id.to_s)
      end

      describe 'attributes' do
        subject(:attributes) { data['attributes'] }

        let(:expected_attributes) do
          {
            'start_time' => start_time.as_json,
            'end_time' => end_time.as_json
          }
        end

        it 'contains episode attributes' do
          expect(attributes).to eq(expected_attributes)
        end
      end
    end
  end
end
