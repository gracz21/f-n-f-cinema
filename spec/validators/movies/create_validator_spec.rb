# frozen_string_literal: true

require 'rails_helper'

describe Movies::CreateValidator, type: :validator do
  subject(:validator) { described_class.new }

  describe '#validate' do
    subject(:validate) { validator.validate(params) }

    let(:params) do
      {
        omdb_id: omdb_id,
        price: price
      }
    end

    let(:omdb_id) { 'tt0232500' }
    let(:price) { 15.0 }

    it 'does not raise any validation errors' do
      expect { validate }.not_to raise_error
    end

    context 'with empty OMDb ID' do
      let(:omdb_id) { '' }

      it_behaves_like 'failing validation'
    end

    context 'with already used OMDb ID' do
      before { Movie.create(omdb_id: omdb_id) }

      it_behaves_like 'failing validation'
    end

    context 'with empty price' do
      let(:price) { nil }

      it_behaves_like 'failing validation'
    end
  end
end
