# frozen_string_literal: true

require 'rails_helper'

describe MovieRatings::CreateValidator, type: :validator do
  subject(:validator) { described_class.new }

  describe '#validate' do
    subject(:validate) { validator.validate(params) }

    let(:params) do
      {
        rating: rating,
        creator: creator,
        movie: movie
      }
    end

    let(:rating) { 5 }
    let(:creator) { User.create! }
    let(:movie) { Movie.create! }

    it 'does not raise any validation errors' do
      expect { validate }.not_to raise_error
    end

    context 'with empty rating' do
      let(:rating) { nil }

      it_behaves_like 'failing validation'
    end

    context 'with invalid rating value' do
      let(:rating) { 6 }

      it_behaves_like 'failing validation'
    end

    context 'when given movie was already rated by given user' do
      before { MovieRating.create!(creator: creator, movie: movie) }

      it_behaves_like 'failing validation'
    end
  end
end
