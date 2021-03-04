# frozen_string_literal: true

require 'rails_helper'

describe ShowTime, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:movie) }
  end
end
