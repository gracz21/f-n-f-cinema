# frozen_string_literal: true

require 'rails_helper'

describe Movies::CreateSerializer, type: :serializer do
  subject(:serializer) { described_class.new(movie) }

  let(:movie) { Movie.create(omdb_id: omdb_id, price: price) }

  let(:omdb_id) { 'tt0232500' }
  let(:price) { 13.0 }

  describe '#as_json' do
    subject(:as_json) { serializer.as_json }

    describe 'data' do
      subject(:data) { as_json['data'] }

      it 'contains correct type' do
        expect(data['type']).to eq('movie')
      end

      it 'contains correct id' do
        expect(data['id']).to eq(movie.id.to_s)
      end

      describe 'attributes' do
        subject(:attributes) { data['attributes'] }

        let(:expected_attributes) do
          {
            'omdb_id' => omdb_id,
            'price' => price
          }
        end

        it 'contains episode attributes' do
          expect(attributes).to eq(expected_attributes)
        end
      end
    end
  end
end
