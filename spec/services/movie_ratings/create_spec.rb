# frozen_string_literal: true

require 'rails_helper'

describe MovieRatings::Create, type: :service do
  subject(:service) { described_class.new }

  describe '#call' do
    subject(:call) { service.call(movie: movie, rating: rating, creator: user) }

    let(:movie) { Movie.create(overall_ratings_sum: 0, overall_ratings_count: 0) }
    let(:user) { User.create }
    let(:rating) { 4 }

    let(:expected_attributes) do
      {
        'movie_id' => movie.id,
        'user_id' => user.id,
        'rating' => rating
      }
    end

    it 'creates a new movie rating record' do
      expect { call }.to change(MovieRating, :count).by(1)
    end

    it 'creates a new movie rating with proper attributes' do
      expect(call.attributes).to include(expected_attributes)
    end

    it 'increments the movie overall ratings sum by given rating' do
      expect { call }.to change(movie, :overall_ratings_sum).by(rating)
    end

    it 'increments the movie overall ratings count by one' do
      expect { call }.to change(movie, :overall_ratings_count).by(1)
    end
  end
end
