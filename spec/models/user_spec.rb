# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  describe 'associations' do
    it do
      is_expected
        .to have_many(:ratings)
        .class_name('MovieRating')
        .with_foreign_key(:user_id)
        .inverse_of(:creator)
        .dependent(:destroy)
    end
  end

  describe '#role?' do
    subject(:call) { user.role?(role) }

    let(:user) { User.create!(is_cinema_worker: is_cinema_worker) }
    let(:role) { UserRoles::CINEMA_WORKER }

    context 'when user has requested role' do
      let(:is_cinema_worker) { true }

      it { expect(call).to be_truthy }
    end

    context 'when user does not have requested role' do
      let(:is_cinema_worker) { false }

      it { expect(call).to be_falsey }
    end
  end
end
