# frozen_string_literal: true

require 'rails_helper'

describe CinemaWorkersPolicy, type: :policy do
  subject(:policy) { described_class.new(user, resource) }

  describe '#create?' do
    subject(:call) { policy.create? }

    let(:user) { User.create!(is_cinema_worker: is_cinema_worker) }
    let(:resource) { User }

    context 'when given user is a cinema worker' do
      let(:is_cinema_worker) { true }

      it { expect(call).to be_truthy }
    end

    context 'when given user is not a cinema worker' do
      let(:is_cinema_worker) { false }

      it { expect(call).to be_falsey }
    end
  end
end
