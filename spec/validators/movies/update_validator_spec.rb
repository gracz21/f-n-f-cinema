# frozen_string_literal: true

require 'rails_helper'

describe Movies::UpdateValidator, type: :validator do
  subject(:validator) { described_class.new }

  describe '#validate' do
    subject(:validate) { validator.validate(params) }

    let(:params) do
      {
        price: price
      }
    end

    let(:price) { 15.0 }

    it 'does not raise any validation errors' do
      expect { validate }.not_to raise_error
    end

    context 'with empty price' do
      let(:price) { nil }

      it_behaves_like 'failing validation'
    end

    context 'without price given' do
      let(:params) { {} }

      it 'does not raise any validation errors' do
        expect { validate }.not_to raise_error
      end
    end
  end
end
