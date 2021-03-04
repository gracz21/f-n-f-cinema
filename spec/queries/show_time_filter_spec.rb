# frozen_string_literal: true

require 'rails_helper'

describe ShowTimeFilter, type: :query do
  subject(:query) { described_class.new }

  describe '#call' do
    subject(:call) { query.call(filters) }

    let(:movie) { Movie.create! }
    let!(:show_time1) { ShowTime.create!(movie: movie, start_time: (Time.current + 2.day)) }
    let!(:show_time2) { ShowTime.create!(movie: movie, start_time: (Time.current + 1.day)) }

    context 'with no filters given' do
      let(:filters) { {} }

      it 'returns all show times' do
        expect(call).to contain_exactly(show_time1, show_time2)
      end
    end

    context 'with date filter given' do
      let(:filters) do
        {
          show_date: Date.current + 1.day
        }
      end

      it 'returns only matching show times' do
        expect(call).to contain_exactly(show_time2)
      end
    end
  end
end
