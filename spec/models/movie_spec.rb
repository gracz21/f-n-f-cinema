# frozen_string_literal: true

require 'rails_helper'

describe Movie, type: :model do
  describe 'associations' do
    it do
      is_expected
        .to have_many(:ratings)
        .class_name('MovieRating')
        .with_foreign_key(:movie_id)
        .inverse_of(:movie)
        .dependent(:destroy)
    end

    it { is_expected.to have_many(:show_times).dependent(:destroy) }
  end
end
