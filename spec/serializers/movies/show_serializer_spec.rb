# frozen_string_literal: true

require 'rails_helper'

describe Movies::ShowSerializer, type: :serializer do
  subject(:serializer) { described_class.new(movie) }

  let(:movie) do
    Movie.create!(
      omdb_id: omdb_id,
      price: price,
      name: name,
      description: description,
      release_date: release_date,
      imdb_rating: imdb_rating,
      runtime: runtime,
      overall_ratings_count: overall_ratings_count,
      overall_ratings_sum: 9
    )
  end

  let(:omdb_id) { 'tt0232500' }
  let(:price) { 13.0 }
  let(:name) { 'Cool movie' }
  let(:description) { 'Some cool movie about cool dudes' }
  let(:release_date) { '22 Jun 2021' }
  let(:imdb_rating) { '9.59' }
  let(:runtime) { '120 min' }
  let(:overall_ratings_count) { 2 }

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
            'price' => price,
            'name' => name,
            'description' => description,
            'release_date' => release_date,
            'imdb_rating' => imdb_rating,
            'runtime' => runtime,
            'rating' => 4.5
          }
        end

        it 'contains episode attributes' do
          expect(attributes).to eq(expected_attributes)
        end

        context 'with no ratings yet' do
          let(:overall_ratings_count) { 0 }

          it 'returns 0 as the rating' do
            expect(attributes['rating']).to eq(0)
          end
        end
      end
    end
  end
end
